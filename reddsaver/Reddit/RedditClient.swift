//
//  RedditClient.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/7/23.
//

import Foundation
import Alamofire
import SwiftyJSON

//     https://github.com/reddit-archive/reddit/wiki/API
//
//     http://api.reddit.com/*.json
//
//     http://www.reddit.com/*.json
//
//     Some endpoints are oauth only, and oauth works with the same
//     http://oauth.reddit.com/-.json
//
//     In 4 days non oauth requests will be rate limited more harshly
//     https://www.reddit.com/r/redditdev/comments/4a1bts/what_is_the_domain_for_the_api_requests/

class RedditClient {
    static let shared = RedditClient()

    
    
    
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
            getSavedItems(token: validToken, username: user)

        }
    }
    
    private func getSavedItems(token: String, username: String) {
        let urlPath = "http://oauth.reddit.com/user/\(username)/saved.json"
        let tokenHeaders: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(urlPath, headers: tokenHeaders).responseDecodable(of: RedditResponse.Root.self) { response in
            switch response.result {
            case .success:
                do {
                    let items = try response.result.get()
                    debugPrint(items)
                } catch {
                    // TODO: log it
                    print("ml: Failed to decode RedditResponse.Root")
                }
            case .failure(let error):
                // TODO:
                print("\(error)")
            }
        }
    }
    
    // for debug only
    private func getDebugItems(token: String, username: String) {
        let urlPath = "http://oauth.reddit.com/user/\(username)/saved.json"
        let tokenHeaders: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(urlPath, headers: tokenHeaders).responseJSON { response in
            guard let datums = response.data else {
                // TODO:
                return
            }
            
            let stringValue = String(decoding: datums, as: UTF8.self)
            debugPrint(stringValue)

            let JSONObject = try? JSON(data: datums)
            print(JSONObject!)

        }
    }
}








