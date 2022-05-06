//
//  GCLog.swift
//  GCLogSwift
//
//  Created by Thinh Nguyen on 06/05/2022.
//

import Foundation

/***
 * GC LOG WRITER
 * Console
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

class URLRequestLogParser: HttpLogParser {
    func getHeaders(from: Any?) -> [String : String]? {
        guard let req = from as? URLRequest else { return nil }
        return req.allHTTPHeaderFields
    }
    
    func getUrl(from: Any?) -> String? {
        guard let req = from as? URLRequest else { return nil }
        guard let url =  req.url else { return nil}
        return url.absoluteString
    }
    
    func getBody(from: Any?) -> String? {
        guard let req = from as? URLRequest else { return nil }
        if let data = req.httpBody, let body = String(data: data, encoding: .utf8) {
            return body
        }
        return nil
    }
    
    func getMethod(from: Any?) -> String? {
        guard let req = from as? URLRequest else { return nil }
        return req.httpMethod
    }
}

/***
 * GC LOG
 * use(writer) to log(any) powered by use(parser)
 ***/
open class GcLog {
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
