import Foundation

public struct Response: Sendable {
    public let data: Data
    public let statusCode: Int
    public let headers: [String: String]
    
    public init(data: Data, statusCode: Int, headers: [String: String]) {
        self.data = data
        self.statusCode = statusCode
        self.headers = headers
    }
}
