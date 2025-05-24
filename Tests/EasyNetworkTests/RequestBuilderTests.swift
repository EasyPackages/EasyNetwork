import Testing
import Foundation

import EasyTesting

@testable import EasyNetwork

@Suite("RequestBuilderTests")
struct RequestBuilderTests {
    @Test("should create a request with the correct URL")
    func shouldCreateRequestWithCorrectURL() throws {
        let url = URL.mock()
        let request = try Request.Builder()
            .url(url)
            .build
        #expect(request.url == url)
    }
    
    @Test("should create a request with the correct method")
    func shouldCrateRequestWithCorrectMethod() throws {
        let method = HTTPMethod.post
        let request = try Request.Builder()
            .url(.mock())
            .method(method)
            .build
        #expect(request.method == method)
    }
    
    @Test("should create a request with the correct timeout")
    func shouldCreateRequestWithTheCorrectTimout() throws {
        let timeout: TimeInterval = 5.0
        let request = try Request.Builder()
            .url(.mock())
            .timeout(timeout)
            .build
        #expect(request.timeout == timeout)
    }
    
    @Test("should create a request with the correct headers")
    func shouldCreateRequestWithCorrectHeaders() throws {
        let headers = ["Authorization": "Bearer token"]
        let request = try Request.Builder()
            .url(.mock())
            .headers(headers)
            .build
        #expect(request.headers == headers)
    }
    
    @Test("should create a request with the correct body")
    func shouldCreateRequestWithCorrectBody() throws {
        let body = Data.mock()
        let request = try Request.Builder()
            .url(.mock())
            .body(body)
            .build
        #expect(request.body == body)
    }
    
    @Test("should throw an error if URL is not set")
    func shouldThrowErrorURLisNotSet() async {
        let builder = Request.Builder()
        await expect(try builder.build, throws: NetworkError.invalidUrl)
    }
    
    @Test("defaults to GET method")
    func testDefaultsToGetMethod() throws {
        let url = URL.mock()
        let request = try Request.Builder()
            .url(url)
            .build
        #expect(request.method == .get)
    }
    
    @Test("defaults to nil body")
    func testDefaultsToNilBody() throws {
        let url = URL.mock()
        let request = try Request.Builder()
            .url(url)
            .build
        #expect(request.body == nil)
    }
    
    @Test("defaults to empty headers")
    func testDefaultsToEmptyHeaders() throws {
        let url = URL.mock()
        let request = try Request.Builder()
            .url(url)
            .build
        #expect(request.headers == [:])
    }
    
    @Test("defaults to 10.0 seconds timeout")
    func testDefaultsToTenSecondsTimeout() throws {
        let url = URL.mock()
        let request = try Request.Builder()
            .url(url)
            .build
        #expect(request.timeout == 10.0)
    }
}
