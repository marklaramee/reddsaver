//
//  OAuthViewModel.swift
//  reddsaver
//
//  Created by Mark Laramee on 2/1/23.
//

import Foundation
import UIKit

class OAuthViewModel {
    
    var redirectPath = "reddsaver://oauth-callback"
    
    lazy var validationString = String.random(size: 42)
        
    var oAuthToken: String? {
        let token: String? = UserStorage.shared.readGlobalValue(forKey: .accessToken)
        return token
    }
    
    // TODO: cleanup
    var clientId: String? {
        let clientId = Bundle.main.infoDictionary?["API_KEY"] as? String
        return clientId
    }
    
    func saveTokens(response: RedditResponse) {
        print("ML: acccess_token \(response.access_token)")
        print("ML: refresh_token \(response.refresh_token)")
        UserStorage.shared.saveGlobalValue(forKey: .accessToken, value: response.access_token)
        UserStorage.shared.saveGlobalValue(forKey: .refreshToken, value: response.refresh_token)
    }
    
}
