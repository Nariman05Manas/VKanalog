//
//  UserProfileInteractor.swift
//  VKanalog
//
//  Created by qwerty on 01.02.2023.
//

import UIKit

protocol UserProfileBusinessLogic {
    func makeRequest(request: UserProfile.Model.Request.RequestType)
}

final class UserProfileInteractor: UserProfileBusinessLogic {
    
    var presenter: UserProfilePresentationLogic?
    
    func makeRequest(request: UserProfile.Model.Request.RequestType) {
        
        switch request {
        case .getUserInfo:
            // Получаем свежие данные о пользователе
            NetworkService.shared.getUserProfile { [weak self] responce in
                guard let responce = responce?.response[0] else { return }
                let user = UserInfo(id: responce.id, firstName: responce.firstName, lastName: responce.lastName, about: responce.about, status: responce.status, photo200: responce.photo200)
                LocalStorage.shared.addUserInfo(user: user)
                
                let userModel = UserProfileResponseWrapped(response: [responce])
                
                // Заполняем массив фотографий для хедера страницы пользователя
                LocalStorage.shared.getFirstPhotos()
                
                self?.presenter?.presentData(response: UserProfile.Model.Response.ResponseType.presentUserInfo(user: userModel))
            }
            
        case .getWall:
            // Получаем данные о записях на стене
            NetworkService.shared.getWall { [weak self] responce in
                guard let wallResponse = responce else { return }
                self?.presenter?.presentData(response: UserProfile.Model.Response.ResponseType.presentWall(wall: wallResponse))
            }
        }
    }
}
