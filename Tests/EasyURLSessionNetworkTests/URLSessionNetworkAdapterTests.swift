import Testing
import Foundation

import EasyNetwork
import EasyTesting

@testable import EasyURLSessionNetwork

@Suite("URLSessionNetworkAdapter")
struct URLSessionNetworkAdapterTests {
    
    @Test("Throws .invalidResponse when session throws it")
    func testThrowsInvalidResponseFromSession() async {
        let error = NetworkError.invalidResponse
        let env = makeEnv()
        env.sessionMock.requestDataMocked.mock(throwing: error)
        
        await expect(try await env.sut.request(.mock()), throws: error)
    }
    
    @Test("Throws .invalidUrl when session throws it explicitly")
    func testThrowsInvalidUrlFromSession() async {
        let error = NetworkError.invalidUrl
        let env = makeEnv()
        env.sessionMock.requestDataMocked.mock(throwing: error)
        
        await expect(try await env.sut.request(.mock()), throws: error)
    }
    
    @Test("Throws .unexpected when session throws unexpected error")
    func testThrowsUnexpectedErrorFromSession() async {
        let error = NetworkError.unexpected
        let env = makeEnv()
        env.sessionMock.requestDataMocked.mock(throwing: error)
        
        await expect(try await env.sut.request(.mock()), throws: error)
    }
    
    @Test("Maps unknown NSError to .unexpected")
    func testMapsUnknownNSErrorToUnexpectedError() async {
        let error = NSError(domain: "any.error", code: -1)
        let env = makeEnv()
        env.sessionMock.requestDataMocked.mock(throwing: error)
        
        await expect(try await env.sut.request(.mock()), throws: NetworkError.unexpected)
    }
    
    @Test("Sends request with expected metadata to session")
    func testSendsExpectedRequestMetadata() async throws {
        let request = Request.mock(
            url:  URL(string: "https://any.com")!,
            method: .delete,
            timeout: 0.123,
            headers: ["k": "v"],
            body: .mock()
        )
        let env = makeEnv()
        
        _ = try await env.sut.request(request)
        
        #expect(env.sessionMock.requestDataMocked.spies == [request.urlRequest])
    }
    
    @Test("Reuses request data correctly on consecutive calls")
    func testRequestSpyMatchesExpectedValues() async throws {
        let request = Request.mock(
            url:  URL(string: "https://any.com")!,
            method: .post,
            timeout: 0.123,
            headers: ["k": "v"],
            body: .mock()
        )
        let env = makeEnv()
        
        _ = try await env.sut.request(request)
        
        #expect(env.sessionMock.requestDataMocked.spies == [request.urlRequest])
    }
    
    @Test("Preserves request body in spy tracking")
    func testRequestBodyIsPassedToSessionCorrectly() async throws {
        let request = Request.mock(
            url: .mock(),
            method: .put,
            timeout: 0.123,
            headers: ["k": "v"],
            body: .mock()
        )
        let env = makeEnv()
        
        _ = try await env.sut.request(request)
        
        #expect(env.sessionMock.requestDataMocked.spies.map(\.httpBody) == [request.body])
    }
    
    @Test("Returns response with statusCode 200")
    func testReturns200StatusCode() async throws {
        let statusCode = 200
        let env = makeEnv()
        env.sessionMock.requestDataMocked.mock(returning: (
            .mock(),
            HTTPURLResponse.mock(statusCode: statusCode))
        )
        
        let response = try await env.sut.request(.mock())
        
        #expect(response.statusCode == statusCode)
    }
    
    @Test("Throws .invalidResponse when response is not HTTPURLResponse")
    func testThrowsInvalidResponseWhenNonHTTPURLResponse() async throws {
        let env = makeEnv()
        env.sessionMock.requestDataMocked.mock(returning: (
            .mock(),
            URLResponse())
        )
        
        await expect(try await env.sut.request(.mock()), throws: NetworkError.invalidResponse)
    }
    
    @Test("Returns response with statusCode 201")
    func testReturns201StatusCode() async throws {
        let statusCode = 201
        let env = makeEnv()
        env.sessionMock.requestDataMocked.mock(returning: (
            .mock(),
            HTTPURLResponse.mock(statusCode: statusCode))
        )
        
        let response = try await env.sut.request(.mock())
        
        #expect(response.statusCode == statusCode)
    }
    
    @Test("Returns response with statusCode 400")
    func testReturns400StatusCode() async throws {
        let statusCode = 400
        let env = makeEnv()
        env.sessionMock.requestDataMocked.mock(returning: (
            .mock(),
            HTTPURLResponse.mock(statusCode: statusCode))
        )
        
        let response = try await env.sut.request(.mock())
        
        #expect(response.statusCode == statusCode)
    }
    
    @Test("Returns response with statusCode 500")
    func testReturns500StatusCode() async throws {
        let statusCode = 500
        let env = makeEnv()
        env.sessionMock.requestDataMocked.mock(returning: (
            .mock(),
            HTTPURLResponse.mock(statusCode: statusCode))
        )
        
        let response = try await env.sut.request(.mock())
        
        #expect(response.statusCode == statusCode)
    }
    
    @Test("Returns headers from HTTPURLResponse")
    func testReturnsHeadersFromHTTPURLResponse() async throws {
        let headers = ["any-header-key": "any-header-value"]
        let env = makeEnv()
        env.sessionMock.requestDataMocked.mock(returning: (.mock(), HTTPURLResponse.mock(headers: headers)))
        
        let response = try await env.sut.request(.mock())
        
        #expect(response.headers == headers)
    }
    
    @Test("Returns correct data from response body")
    func testReturnsDataFromResponse() async throws {
        let dataStub = Data.mock()
        let env = makeEnv()
        env.sessionMock.requestDataMocked.mock(returning: (
            dataStub,
            HTTPURLResponse.mock())
        )
        
        let response = try await env.sut.request(.mock())
        
        #expect(response.data == dataStub)
    }
    
    @Test("Returns correct data from response body (duplicate validation)")
    func testReturnsExpectedDataOnDuplicateCall() async throws {
        let dataStub = Data.mock()
        let env = makeEnv()
        env.sessionMock.requestDataMocked.mock(returning: (
            dataStub,
            HTTPURLResponse.mock())
        )
        
        let response = try await env.sut.request(.mock())
        
        #expect(response.data == dataStub)
    }
    
    private struct Environment {
        let sut: URLSessionNetworkAdapter
        let sessionMock: URLSessionMock
    }
    
    private func makeEnv() -> Environment {
        let sessionMock = URLSessionMock()
        let sut = URLSessionNetworkAdapter(session: sessionMock)
        
        return Environment(sut: sut, sessionMock: sessionMock)
    }
}
