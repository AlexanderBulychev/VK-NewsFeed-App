//
//  NewsfeedModels.swift
//  VK NewsFeed App
//
//  Created by asbul on 29.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

enum Newsfeed {

    enum Model {
        struct Request {
            enum RequestType {
                case getNewsFeed
            }
        }
        
        struct Response {
            enum ResponseType {
                case presentNewsFeed(feed: FeedResponse)
            }
            
        }
        
        struct ViewModel {
            enum ViewModelData {
                case displayNewsFeed(feedViewModel: FeedViewModel)
            }
        }
    }
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttachment: FeedCellPhotoAttachmentViewModel?
    }
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
        var photoUrlString: String?
        var width: Int
        var height: Int
    }
    let cells: [Cell]
}
