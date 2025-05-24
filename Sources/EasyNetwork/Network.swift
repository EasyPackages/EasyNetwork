public protocol Network: Sendable {
    func request(_ request: Request) async throws(NetworkError) -> Response
}
