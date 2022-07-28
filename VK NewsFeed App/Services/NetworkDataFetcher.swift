import Foundation

protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {

    let networking: Networking

    init(networking: Networking) {
        self.networking = networking
    }

    func getFeed(response: @escaping (FeedResponse?) -> Void) {
        let params = ["filters": "post,photo"]
        networking.request(path: API.newsFeed, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = decodeJSON(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }

    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }

}
