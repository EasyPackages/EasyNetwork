import Foundation

import EasyNetwork

extension Request {
    var urlRequest: URLRequest {
        var urlRequest = URLRequest(
            url: url,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: timeout
        )
        urlRequest.httpMethod = method.rawValue.uppercased()
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = body
        return urlRequest
    }
}
