import Foundation

@available(iOS 15.0, *)
extension URLSession: URLSessionProvider {
    public func requestData(_ request: URLRequest) async throws -> (Data, URLResponse) {
        try await data(for: request)
    }
}
