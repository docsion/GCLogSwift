//
//  URLRequestLogParser.swift
//  GCLog
//
//  Created by Thinh Nguyen on 06/05/2022.
//

import Foundation

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
