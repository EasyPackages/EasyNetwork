import Foundation

import EasyNetwork

public protocol URLSessionProvider: Sendable {
    func requestData(_ request: URLRequest) async throws -> (Data, URLResponse)
}

@available(iOS 15.0, *)
public struct URLSessionNetworkAdapter: Network {
    private let session: URLSessionProvider
    
    public init(session: URLSessionProvider = URLSession.shared) {
        self.session = session
    }
    
    public func request(_ request: Request) async throws(NetworkError) -> Response {
        do {
            let (data, response) = try await session.requestData(request.urlRequest)
            
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            var headers = [String: String]()
            response.allHeaderFields.forEach { dict in
                headers["\(dict.key)"] = "\(dict.value)"
            }
            
            return Response(
                data: data,
                statusCode: response.statusCode,
                headers: headers
            )
        } catch {
            if let networkError = error as? NetworkError {
                throw networkError
            }
            
            throw .unexpected
        }
    }
}
