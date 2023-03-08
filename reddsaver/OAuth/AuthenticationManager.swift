//
//  TokenManager.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/7/23.
//

import Foundation
import UIKit

class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    
    init() {
        // TODO: for debugging 
//        UserStorage.shared.deleteGlobalValue(forKey: .accessToken)
//        UserStorage.shared.deleteGlobalValue(forKey: .refreshToken)
//        UserStorage.shared.deleteGlobalValue(forKey: .username)
    }
    
    var username: String? {
        let name: String? = UserStorage.shared.readGlobalValue(forKey: .username)
        return name
    }
    
    var accessToken: String? {
        let token: String? = UserStorage.shared.readGlobalValue(forKey: .accessToken)
        return token
    }
    
    var isAuthenticationComplete: Bool {
        return username != nil && accessToken != nil
    }
    
    // TODO: build in failure/success
    func getCurrentAccessToken(completion: (String?) -> Void) {
        let token: String? = UserStorage.shared.readGlobalValue(forKey: .accessToken)
        completion(token)
        return
    }
    
   func saveTokens(response: RedditResponse) {
       // TODO: remove
        print("ML: acccess_token \(response.access_token)")
        print("ML: refresh_token \(response.refresh_token)")
        UserStorage.shared.saveGlobalValue(forKey: .accessToken, value: response.access_token)
        UserStorage.shared.saveGlobalValue(forKey: .refreshToken, value: response.refresh_token)
        if #available(iOS 15, *) {
            UserStorage.shared.saveGlobalValue(forKey: .tokenExpiration, value: Date.now.addingTimeInterval(3600))
        } else {
            // TODO: Fallback on earlier versions
        }
    }
    
    func logInUser(username: String, completion: (Bool) -> Void) {
        // TODO: authenticate with reddit
        // TODO: save on user basis, not global
        UserStorage.shared.saveGlobalValue(forKey: .username, value: username)
        completion(true)
    }
    
    func nextViewController() -> UIViewController? {
        guard username != nil else {
            return LogInViewController.newInstance()
        }
        guard accessToken != nil else {
            return OAuthViewController.newInstance()
        }
        return nil
    }
    
    func navigateToNextViewController(_ navController: UINavigationController?) {
        guard let nextVC = nextViewController() else {
            // OAuth flow completed, go to home screen
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate
              else {
                return
              }
            sceneDelegate.window?.rootViewController = RootTabBarController.newInstance()
            return
        }
        navController?.pushViewController(nextVC, animated: true)
    }
}
