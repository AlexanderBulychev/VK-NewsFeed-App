//
//  AppDelegate.swift
//  VK NewsFeed App
//
//  Created by asbul on 18.07.2022.
//

import UIKit
import VK_ios_sdk

@main
class AppDelegate: UIResponder, UIApplicationDelegate, AuthServiceDelegate {

    var window: UIWindow?
    var authService: AuthService!

    static func shared() -> AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }

//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//        window = UIWindow()
//
//        self.authService = AuthService()
//        authService.delegate = self
//
//        let scope = ["wall", "friends"]
//        VKSdk.wakeUpSession(scope) { (state, _) in
//            if state == VKAuthorizationState.authorized {
//                self.authServiceSignIn()
//            } else {
//                self.authVC()
//            }
//        }
//
//        return true
//    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()

        self.authService = AuthService()
        authService.delegate = self

        let authVC: AuthViewController = AuthViewController.loadFromStoryboard()

        window?.rootViewController = authVC
        window?.makeKeyAndVisible()

        return true
    }

    open func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }

    // MARK: - AuthServiceDelegate

    func authServiceShouldShow(_ viewController: UIViewController) {
        print(#function)
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }

    func authServiceSignIn() {
        print(#function)
        let feedVC: NewsfeedViewController = NewsfeedViewController.loadFromStoryboard()
        let navVC = UINavigationController(rootViewController: feedVC)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
    
    func authServiceDidSignInFail() {
        print(#function)
    }

    func authVC() {
        print(#function)
        let authVC: AuthViewController = UIViewController.loadFromStoryboard()
        window?.rootViewController = UINavigationController(rootViewController: authVC)
        window?.makeKeyAndVisible()
    }


}

