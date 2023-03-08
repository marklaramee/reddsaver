//
//  RedditClient.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/7/23.
//

import Foundation
import Alamofire
import SwiftyJSON

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
        let tokenHeaders: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(urlPath, headers: tokenHeaders).responseJSON { response in
            guard let datums = response.data else {
                // TODO:
                return
            }
                let stringValue = String(decoding: datums, as: UTF8.self)
                debugPrint(stringValue)
                let nnn = stringValue
            
            
            let JSONObject = try? JSON(data: datums)
            var ppp = 1
            print(JSONObject!)
            ppp = 2
            
//            if let JSONObject = try? JSONSerialization.jsonObject(with: datums, options: .allowFragments) as? [[String: Any]] {
//                var ppp = 1
//                print(JSONObject)
//                ppp = 2
//
//                    // There's our username
//            }
            
            
            
//              let json = JSON(data: response.data!)
//              let name = json["people"][0]["name"].string
//              if name != nil {
//                print(name!)
//              }
           // }
        }
            
            
            
//            .response { response in
//
//
//            switch response.result {
//            case .success:
//                if let data = response.data {
//                    do {
//                        debugPrint(data)
//                        let nnn = data
////                        let bets = try JSONDecoder().decode(Bets.self, from: data)
////                        print("message: \(bets.message)")
////
////                        self.setupTableData()
////                        completion?(true)
//                    } catch {
////                        print("Error: \(error)")
////                        completion?(false)
//                    }
//                }
//            case.failure(let error):
//                print(error)
//                // completion?(false)
//            }
        // }
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








