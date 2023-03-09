//
//  RedditViewModel.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/8/23.
//

import Foundation
import RxSwift
import RxRelay

class RedditViewModel {
    var client: RedditClient?
    let items: BehaviorRelay<RedditResponse.Root?> = BehaviorRelay(value: nil)
    
    init(client: RedditClient) {
        self.client = client
    }
    
    func getPagedItems() {
        guard let user = AuthenticationManager.shared.username else {
            // TODO: handle error
            return
        }
        AuthenticationManager.shared.getCurrentAccessToken { token in
            guard let validToken = token else {
                ReddLogger.shared.log(level: .error, message: "No token available", category: .token)
                // TODO: handle with success/fail and log in other method
                return
            }
            self.client?.getSavedItems(token: validToken, username: user) { response in
                guard let root = response else {
                    return
                }
                self.items.accept(root)
            }
        }
    }
}
