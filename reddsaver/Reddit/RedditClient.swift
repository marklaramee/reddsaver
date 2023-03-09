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
//     http://oauth.reddit.com/*.json
//
//     In 4 days non oauth requests will be rate limited more harshly
//     https://www.reddit.com/r/redditdev/comments/4a1bts/what_is_the_domain_for_the_api_requests/

class RedditClient {
    static let shared = RedditClient()
    
    func getSavedItems(token: String, username: String, completion: @escaping (RedditResponse.Root?) -> Void) {
        let urlPath = "http://oauth.reddit.com/user/\(username)/saved.json"
        let tokenHeaders: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(urlPath, headers: tokenHeaders).responseDecodable(of: RedditResponse.Root.self) { response in
            switch response.result {
            case .success:
                do {
                    let items = try response.result.get()
                    debugPrint(items)
                    completion(items)
                    return
                } catch {
                    // TODO: log it
                    print("ml: Failed to decode RedditResponse.Root")
                    completion(nil)
                }
            case .failure(let error):
                // TODO:
                print("\(error)")
                completion(nil)
            }
        }
    }
    
    // for debug only TODO: delete?
    func getDebugItems(token: String, username: String) {
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








