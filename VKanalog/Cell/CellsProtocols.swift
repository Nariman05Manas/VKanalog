//
//  CellsProtocols.swift
//  VKanalog
//
//  Created by qwerty on 01.02.2023.
//

import UIKit

protocol FeedPostViewModelProtocol {
    var iconUrlString: String? { get }
    var name: String? { get }
    var date: Int? { get }
    var text: String? { get }
    var likes:Int? { get }
    var userLikes: Int? { get }
    var canLike: Int? { get }
    var comments: Int? { get }
    var shares: Int? { get }
    var views: Int? { get }
    var photoAttachment: CellPhotoAttachmentViewModelProtocol? { get }
    var totalHeight: CGFloat? { get }
    var postID: Int? { get }
    var sourceID: Int? { get }
}

protocol WallViewModelProtocol {
//    var iconUrlString: String? { get }
//    var name: String? { get }
    var date: Int? { get }
    var text: String? { get }
    var likes:Int? { get }
    var userLikes: Int? { get }
    var canLike: Int? { get }
    var comments: Int? { get }
    var shares: Int? { get }
    var views: Int? { get }
    var photoAttachment: CellPhotoAttachmentViewModelProtocol? { get }
    var totalHeight: CGFloat? { get }
}

protocol CellPhotoAttachmentViewModelProtocol {
    var photoUrlString: String? { get }
    var width: Int { get set}
    var height: Int { get set}
}
