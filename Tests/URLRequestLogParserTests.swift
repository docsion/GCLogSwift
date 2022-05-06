//
//  URLRequestLogParserTests.swift
//  GCLogTests
//
//  Created by Thinh Nguyen on 06/05/2022.
//

import XCTest
@testable import GCLog

class URLRequestLogParserTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Test 1 headers to prevent dynamic orders
    func testConsoleURLRequestTest() {
        // Create url request
        guard let url = URL(string: "https://api.lucidtech.ai/v0/receipts"),
              let payload = "{\"documentId\": \"a50920e1-214b-4c46-9137-2c03f96aad56\"}".data(using: .utf8) else
        {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("your_api_key", forHTTPHeaderField: "x-api-key")
        request.httpBody = payload
        
        // Log
        let gcl = GcLog.default
        gcl.use(logWritter: StringLogWriter())
        gcl.use(logParser: URLRequestLogParser())
        gcl.log(any: request)
        
        guard let writter = gcl.writter as? StringLogWriter else {
            XCTFail("[Test url request] Writter is not String log writter")
            return
        }
        
        XCTAssert(writter.board == "https://getcurl.app/#body=Y3VybCAnaHR0cHM6Ly9hcGkubHVjaWR0ZWNoLmFpL3YwL3JlY2VpcHRzJyAtWCBQT1NUIC1IICd4LWFwaS1rZXk6IHlvdXJfYXBpX2tleScgLWQgJ3siZG9jdW1lbnRJZCI6ICJhNTA5MjBlMS0yMTRiLTRjNDYtOTEzNy0yYzAzZjk2YWFkNTYifSc=", "Test url request, actual \(writter.board)")

    }

}
