import Foundation

extension Request {
    public actor Builder: Sendable {
        private(set) var url: URL?
        private(set) var method: HTTPMethod = .get
        private(set) var timeout: TimeInterval = 10.0
        private(set) var headers: [String: String] = [:]
        private(set) var body: Data?
        
        public init() {
            // Default initializer
        }
        
        public func url(_ url: URL) -> Self {
            self.url = url
            return self
        }
        
        public func url(_ url: String) -> Self {
            self.url = URL(string: url)
            return self
        }
        
        public func method(_ method: HTTPMethod) -> Self {
            self.method = method
            return self
        }
        
        public func timeout(_ timeout: TimeInterval) -> Self {
            self.timeout = timeout
            return self
        }
        
        public func headers(_ headers: [String: String]) -> Self {
            self.headers = headers
            return self
        }
        
        public func body(_ body: Data?) -> Self {
            self.body = body
            return self
        }
        
        public var build: Request {
            get throws(NetworkError) {
                guard let url else {
                    throw .invalidUrl
                }
                
                return Request(
                    url: url,
                    method: method,
                    timeout: timeout,
                    headers: headers,
                    body: body
                )
            }
        }
    }
}
