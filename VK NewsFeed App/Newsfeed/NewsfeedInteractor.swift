protocol NewsfeedBusinessLogic: AnyObject {
    func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

protocol NewsfeedDataStore {
    
}

final class NewsfeedInteractor: NewsfeedBusinessLogic, NewsfeedDataStore {
    
    var presenter: NewsfeedPresentationLogic?
    var service: NewsfeedService?

    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        switch request {
        case .getNewsFeed:
            fetcher.getFeed { [weak self] feedResponse in

                feedResponse?.groups.map({ group in
                    print("\(group) \n\n")
                })

                feedResponse?.items.map({ feedItem in
                    print(feedItem.sourceId)
                })

                guard let feedResponse = feedResponse else { return }
                self?.presenter?.presentData(response: .presentNewsFeed(feed: feedResponse))
            }
        }
    }
}
