import Foundation

import EasyTesting
import EasyNetwork
import EasyURLSessionNetwork

extension HTTPURLResponse {
    static func mock(statusCode: Int = 200, headers: [String: String] = [:]) -> HTTPURLResponse {
        HTTPURLResponse(
            url: URL(string: "any")!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: headers
        )!
    }
}

extension Request {
    static func mock(
        url: URL = .mock(),
        method: HTTPMethod = .get,
        timeout: TimeInterval = 10.0,
        headers: [String: String] = [:],
        body: Data? = nil
    ) -> Request {
        Request(
            url: url,
            method: method,
            timeout: timeout,
            headers: headers,
            body: body
        )
    }
}
