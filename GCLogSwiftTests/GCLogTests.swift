//
//  GCLogSwiftTests.swift
//  GCLogSwiftTests
//
//  Created by Thinh Nguyen on 06/05/2022.
//

import XCTest
@testable import GCLogSwift


class StringLogWriter: GcLogWritter {
    var board: String
    
    init() {
        board = ""
    }
    
    func write(content: String) {
        board = content
    }
}

class GCLogSwiftTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testConsole() {
        // Log
        let gcl = GcLog.default
        gcl.use(logWritter: StringLogWriter())
        gcl.use(logParser: StringLogParser())
        gcl.log(any: "curl 'https://mocha.lozi.vn/v6/search/eateries/promoted?cityId=50&limit=12&page=1&superCategoryId=1&lat=10.7765194&lng=106.700987' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:99.0) Gecko/20100101 Firefox/99.0' -H 'Accept: */*' -H 'Accept-Language: vi_VN' -H 'Accept-Encoding: gzip, deflate, br' -H 'X-Access-Token: unknown' -H 'X-City-ID: 50' -H 'X-Lozi-Client: 1' -H 'Origin: https://loship.vn' -H 'DNT: 1' -H 'Connection: keep-alive' -H 'Referer: https://loship.vn/' -H 'Sec-Fetch-Dest: empty' -H 'Sec-Fetch-Mode: cors' -H 'Sec-Fetch-Site: cross-site' -H 'TE: trailers'")

        guard let writter = gcl.writter as? StringLogWriter else {
            XCTFail("Test string: Writter is not String log writter")
            return
        }
        
        XCTAssert(writter.board == "https://getcurl.app/#body=Y3VybCAnaHR0cHM6Ly9tb2NoYS5sb3ppLnZuL3Y2L3NlYXJjaC9lYXRlcmllcy9wcm9tb3RlZD9jaXR5SWQ9NTAmbGltaXQ9MTImcGFnZT0xJnN1cGVyQ2F0ZWdvcnlJZD0xJmxhdD0xMC43NzY1MTk0JmxuZz0xMDYuNzAwOTg3JyAtSCAnVXNlci1BZ2VudDogTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTAuMTU7IHJ2Ojk5LjApIEdlY2tvLzIwMTAwMTAxIEZpcmVmb3gvOTkuMCcgLUggJ0FjY2VwdDogKi8qJyAtSCAnQWNjZXB0LUxhbmd1YWdlOiB2aV9WTicgLUggJ0FjY2VwdC1FbmNvZGluZzogZ3ppcCwgZGVmbGF0ZSwgYnInIC1IICdYLUFjY2Vzcy1Ub2tlbjogdW5rbm93bicgLUggJ1gtQ2l0eS1JRDogNTAnIC1IICdYLUxvemktQ2xpZW50OiAxJyAtSCAnT3JpZ2luOiBodHRwczovL2xvc2hpcC52bicgLUggJ0ROVDogMScgLUggJ0Nvbm5lY3Rpb246IGtlZXAtYWxpdmUnIC1IICdSZWZlcmVyOiBodHRwczovL2xvc2hpcC52bi8nIC1IICdTZWMtRmV0Y2gtRGVzdDogZW1wdHknIC1IICdTZWMtRmV0Y2gtTW9kZTogY29ycycgLUggJ1NlYy1GZXRjaC1TaXRlOiBjcm9zcy1zaXRlJyAtSCAnVEU6IHRyYWlsZXJzJw==", "Test string, actual \(writter.board)")
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
