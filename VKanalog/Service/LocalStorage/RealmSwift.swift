//
//  RealmSwift.swift
//  VKanalog
//
//  Created by qwerty on 01.02.2023.
//

import Foundation
import RealmSwift

final class LocalStorage {
    
    static let shared = LocalStorage()
    
    // При изменении модели (моделей) нужно увеличить данный параметр
    let config = Realm.Configuration(schemaVersion: 1)
    var posts: [FeedViewModel.Post]
    var feedViewModel: FeedViewModel?
    var favouriteViewModel: FeedViewModel?
    var userInfoViewModel: UserInfoViewModel?
    var photosForHeader: [String]?
    var wallViewModel: WallViewModel?
    var wallPosts: [WallViewModel.Post]
    
    init() {
        Realm.Configuration.defaultConfiguration = config
        posts = []
        wallPosts = []
        // Вывести адрес базы данных
        print(Realm.Configuration.defaultConfiguration.fileURL?.path)
    }
}
