//
//  NewsFeedPresenter.swift
//  VKanalog
//
//  Created by qwerty on 01.02.2023.
//

import UIKit

protocol NewsFeedPresentationLogic {
    func presentData(response: NewsFeed.Model.Response.ResponseType)
}

final class NewsFeedPresenter: NewsFeedPresentationLogic {
    weak var viewController: NewsFeedDisplayLogic?
    
    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        
        switch response {
            
        case .saveAndPresentNewsFeed(feed: let feed):
            
            let posts = feed.response.items.map { feedItem in
                postViewModel(feedItem: feedItem, profiles: feed.response.profiles, group: feed.response.groups)
            }
            
            for post in posts {
                
                let currentPost = FeedPost(sourceId: post.sourceID ?? 0, postId: post.postID ?? 0, text: post.text ?? "", date: post.date ?? 0, commentsCount: post.comments ?? 0, likesCount: post.likes ?? 0, userLikes: post.userLikes ?? 0, userCanLike: post.canLike ?? 0, repostsCount: post.shares ?? 0, viewsCount: post.views ?? 0, iconUrlString: post.iconUrlString ?? "", name: post.name ?? "", totalHeight: post.totalHeight ?? .zero, photoAttachmentURL: post.photoAttachment?.photoUrlString ?? "", photoAttachmentWidth: post.photoAttachment?.width ?? 0, photoAttachmentHeight: post.photoAttachment?.height ?? 0)
                
                LocalStorage.shared.addPostsToLocalStorage(post: currentPost)
            }
            
            // тут идет получение данных из бд
            LocalStorage.shared.getFeedModel()
            
            guard let feedViewModel = LocalStorage.shared.feedViewModel else { return }
            
            // и отображение их в контроллере
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModel))
        }
    }
    
    private func postViewModel(feedItem: FeedItem, profiles: [Profile], group: [Group]) -> FeedViewModel.Post {
        
        let profile = self.profile(sourceID: feedItem.sourceId ?? 0, profiles: profiles, groups: group)
        
        let photoAttacment = self.photoAttachment(feedItem: feedItem)
        
        let cellHeightCalc = CalculateCellHeight()
        
        let cellHeight = cellHeightCalc.calculateCellTotalHeight(photoAttachment: photoAttacment, text: feedItem.text)
        return FeedViewModel.Post.init(iconUrlString: profile?.photo ?? "",
                                       name: profile?.name,
                                       date: feedItem.date,
                                       text: feedItem.text,
                                       likes: feedItem.likes?.count,
                                       userLikes: feedItem.likes?.userLikes ,
                                       canLike: feedItem.likes?.canLike,
                                       comments: feedItem.comments?.count,
                                       shares: feedItem.reposts?.count,
                                       views: feedItem.views?.count,
                                       photoAttachment: photoAttacment,
                                       totalHeight: cellHeight,
                                       postID: feedItem.postId,
                                       sourceID: feedItem.sourceId
        )
    }
    
    private func profile(sourceID: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable? {
        
        let profilesOrGroups: [ProfileRepresentable] = sourceID > 0 ? profiles : groups
        let currentSourceID = sourceID > 0 ? sourceID : -sourceID
        let profileRepresentable = profilesOrGroups.first { profileRepresentable -> Bool in
            profileRepresentable.id == currentSourceID
        }
        return profileRepresentable
    }
    
    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedPostPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ attachment in
            attachment.photo
        }), let firstPhoto = photos.first else { return nil }
        
        return FeedViewModel.FeedPostPhotoAttachment(photoUrlString: firstPhoto.url, width: firstPhoto.width, height: firstPhoto.height)
    }
}
