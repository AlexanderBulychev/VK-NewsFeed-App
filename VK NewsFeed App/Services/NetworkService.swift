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

// others
//https://api.vk.com/method/newsfeed.get?access_token=vk1.a.vkw6TS6JsNVax4ZpHu536w743Aqmzld4VK9T2KP4s57UlCfEEkOnKIIoSIkBjXFnI279Tmy2Boh4B5EZTxwc6-9KJDoz44YOF6qv81n_odHVBI9eS7eiAjjkixLD9GJM_MlOOyL5KwYHn2q1VL8FLsBoxNbogxzQYJ9rkUrviXC2SfnaaZFU00DfM_CYU2EP&v=5.101&filters=post,photo

//https://api.vk.com/method/newsfeed.get?access_token=vk1.a.x6AYltknIOKb-EN_NdPs0NQOjZEjYhb1HZaiZOn7mU6F12UCwnk43s4rT2mKFzKzZkfYCNBwiIKkxbD-ETcI-GuAgs75C6V1y3oX_VT4AGIVAN8z9hNkWr-DXSevt4ymS042OAZ-Ly-_AqMAXQKj_gIWMRx4_exmqVbXRxNjRldCSzMlXzI0q4ItgqKkg4eT&v=5.131&filters=post,photo


//https://api.vk.com/method/newsfeed.get?filters=post,photo&v=5.131&access_token=vk1.a.vkw6TS6JsNVax4ZpHu536w743Aqmzld4VK9T2KP4s57UlCfEEkOnKIIoSIkBjXFnI279Tmy2Boh4B5EZTxwc6-9KJDoz44YOF6qv81n_odHVBI9eS7eiAjjkixLD9GJM_MlOOyL5KwYHn2q1VL8FLsBoxNbogxzQYJ9rkUrviXC2SfnaaZFU00DfM_CYU2EP
