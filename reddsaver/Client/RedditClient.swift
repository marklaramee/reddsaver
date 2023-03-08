//
//  RedditClient.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/7/23.
//

import Foundation

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
            getSavedItemsAF(token: validToken, username: user)

        }
    }
    
    private func getSavedItemsAF(token: String, username: String) {
        let urlPath = "http://oauth.reddit.com/user/\(username)/saved.json"
    }
    
    //
    //    private func getSavedItems2(token: String) {
    //        // TODO: get username and move to another function
    //        // "/user/username/saved"
    //
    //        let urlPath = "http://oauth.reddit.com//user/username/saved.json"
    //
    //        guard let url = URL(string: urlPath) else {
    //            // TODO: log this?
    //            return
    //        }
    //
    //        // create the URLRequest with the URL and the HTTP method
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "GET"
    //        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    //
    //        // create a URLSession to perform the request
    //        let session = URLSession.shared
    //
    //
    //        let task = session.dataTask(with: request) { data, response, error in
    //            if let responseError = error {
    //                ReddLogger.shared.log(level: .error, message: "\(responseError)", category: .token)
    //                return
    //            }
    //
    //            guard let data = data else {
    //                ReddLogger.shared.log(level: .error, message: "No data received", category: .token)
    //                return
    //            }
    //
    //            // handle the data
    //            let dataString = String(data: data, encoding: .utf8)!
    //            print(dataString)
    //        }
    //
    //        // start the task
    //        task.resume()
    //    }
    
    

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

    
    

    
    
}








