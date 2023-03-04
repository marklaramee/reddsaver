//
//  RootTabBarViewModel.swift
//  reddsaver
//
//  Created by Mark Laramee on 2/1/23.
//

import Foundation
import UIKit

class OAuthViewModel {

    // TODO: expose tokens from storage
    // let storage = UserStorage.shared
    
    var redirectPath = "reddsaver://oauth-callback"
    
    lazy var validationString = String.random(size: 42)
        
    var oAuthToken: String? {
        let token: String? = UserStorage.shared.readGlobalValue(forKey: .OAuthToken)
        return token
    }
    
    // TODO: cleanup
    var clientId: String? {
        let clientId = Bundle.main.infoDictionary?["API_KEY"] as? String
        return clientId
    }
    
}

enum UpdateType {
    case none
    case flexible
    case immediate
}

