import Foundation

import EasyMock

@testable import EasyURLSessionNetwork

struct URLSessionMock: URLSessionProvider {
    let requestDataMocked = AsyncThrowableMock<URLRequest, (Data, URLResponse)>((Data(), HTTPURLResponse()))
    
    func requestData(_ request: URLRequest) async throws -> (Data, URLResponse) {
        try await requestDataMocked.synchronize(request)
    }
}
