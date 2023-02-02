//
//  AuthViewController.swift
//  VKanalog
//
//  Created by qwerty on 01.02.2023.
//

import UIKit

final class AuthViewController: UIViewController, VKAuthServiceDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = VCConstants.mainViewBackgroungColor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = VCConstants.mainViewBackgroungColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        VKAuthService.shared.delegate = self
        VKAuthService.shared.wakeUpSession()
    }
    
    
    // MARK: AuthServiceDelegate
    func authServiceShouldShow(viewController: UIViewController) {
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    func authServiceSignIn() {
        let tabBarVC = CustomTabBar()
        navigationController?.pushViewController(tabBarVC, animated: false)
        navigationController?.navigationBar.isHidden = false
    }
    
    func authServiceSignInDidFail() {
    }
}
