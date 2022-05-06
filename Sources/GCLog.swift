//
//  GCLog.swift
//  GCLog
//
//  Created by Thinh Nguyen on 06/05/2022.
//

import Foundation

/***
 * GC LOG WRITER
 * write(cURL) to any
 ***/
protocol GcLogWritter {
    func write(content: String)
}

class ConsoleLogWriter: GcLogWritter {
    func write(content: String) {
        print(content)
    }
}

/**
 * GC LOG PARSER
 * parse(any) to cURL string
 **/
protocol GcLogParser {
    func parse(from: Any?) -> String?;
}

class StringLogParser: GcLogParser {
    func parse(from: Any?) -> String? {
        return from as? String
    }
}

protocol HttpLogParser: GcLogParser {
    func getHeaders(from: Any?) -> [String : String]?
    func getUrl(from: Any?) -> String?
    func getBody(from: Any?) -> String?
    func getMethod(from: Any?) -> String?
}

extension HttpLogParser {
    func parse(from: Any?) -> String? {
        var command: [String] = []
        
        // url
        guard let url = getUrl(from: from) else { return nil }
        command.append("curl '\(url)'")
        
        // method
        guard let method = getMethod(from: from) else { return nil}
        if method == "HEAD" {
            command.append(" --head")
        } else {
            command.append("-X \(method)")
        }
        
        // headers, optional
        if let headers = getHeaders(from: from) {
            for (key, value) in headers {
                command.append("-H '\(key): \(value)'")
            }
        }
        
        // data, optional
        if let body = getBody(from: from) {
            command.append("-d '\(body)'")
        }
        
        return command.joined(separator: " ")
    }
}

/***
 * GC LOG
 * use(writer) to log(any) powered by use(parser)
 ***/
class GcLog {
    public static let `default` = GcLog()
    
    var writter: GcLogWritter
    var parser: GcLogParser
    
    init() {
        writter = ConsoleLogWriter()
        parser = StringLogParser()
    }
    
    func use(logWritter: GcLogWritter) {
        writter = logWritter
    }
    
    func use(logParser: GcLogParser) {
        parser = logParser
    }
    
    func logContent(content: String?) {
        let based64Content = base64(content: content);
        guard let encodedContent = based64Content!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        let gcLink = "https://getcurl.app/#body=\(encodedContent)"
        writter.write(content: gcLink)
    }
    
    func log(any: Any?) {
        guard let content = parser.parse(from: any) else { return }
        logContent(content: content)
    }
    
    func base64(content: String?) -> String? {
        return Data(content?.utf8 ?? "".utf8).base64EncodedString()
    }
}
