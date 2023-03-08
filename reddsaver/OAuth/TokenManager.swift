//
//  TokenManager.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/7/23.
//

import Foundation

class TokenManager {
    
    static let shared = TokenManager()
    
    init() {
        // TODO: for debugging 
        UserStorage.shared.deleteGlobalValue(forKey: .accessToken)
        UserStorage.shared.deleteGlobalValue(forKey: .refreshToken)
    }
    
    var accessToken: String? {
        let token: String? = UserStorage.shared.readGlobalValue(forKey: .accessToken)
        return token
    }
    
    func getCurrentAccessToken(completion: @escaping (String) -> Void, onFailure: () -> Void) {
        let nillableToken: String? = UserStorage.shared.readGlobalValue(forKey: .accessToken)
        guard let validToken = nillableToken else {
            onFailure()
            return
        }
        completion(validToken)
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
}
