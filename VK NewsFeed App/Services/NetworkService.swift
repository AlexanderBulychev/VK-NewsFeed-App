import Foundation

protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: Networking {
    private let authService: AuthService

    init(authService: AuthService = AppDelegate.shared().authService) {
        self.authService = authService
    }

    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }

        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version

        guard let url = createURL(from: path, params: allParams) else { return }

        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        print(url)
    }

    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }

    private func createURL(from path: String, params: [String: String]) -> URL? {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return components.url
    }
}
