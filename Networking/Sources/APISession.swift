import Combine
import Foundation

struct APISession {
    private static let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }()

    static func request<Request: APIRequest>(request: Request) -> AnyPublisher<Data, Error> {
        session
            .dataTaskPublisher(for: request.getRequest())
            .retry(3)
            .tryMap {
                guard let response = $1 as? HTTPURLResponse, response.statusCode == 200 else {
                    throw APIErrorResponse.network("")
                }
                return $0
            }
            .eraseToAnyPublisher()
    }
}
