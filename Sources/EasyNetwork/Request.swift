import Foundation

public struct Request: Sendable {
    public let url: URL
    public let method: HTTPMethod
    public let timeout: TimeInterval
    public let headers: [String: String]
    public let body: Data?
    
    public init(
        url: URL,
        method: HTTPMethod,
        timeout: TimeInterval,
        headers: [String: String],
        body: Data?
    ) {
        self.url = url
        self.method = method
        self.timeout = timeout
        self.headers = headers
        self.body = body
    }
}
