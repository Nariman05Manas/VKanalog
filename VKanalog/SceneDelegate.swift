//
//  SceneDelegate.swift
//  VKanalog
//
//  Created by qwerty on 01.02.2023.
//

import UIKit
import VKSdkFramework

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow? {
      didSet {
        window?.overrideUserInterfaceStyle = .light
      }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        // Контроллеры приложения
        let authVC = AuthViewController()
        let navigationVC = UINavigationController(rootViewController: authVC)

        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        }
    }
}
