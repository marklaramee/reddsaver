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
    
    // TODO: cleanup
    var clientId: String? {
        let clientId = Bundle.main.infoDictionary?["API_KEY"] as? String
        return clientId
    }
    
    // https://github.com/reddit-archive/reddit/wiki/OAuth2#retrieving-the-access-token
    /*
     return completion success or failure
     */
    func getAccessToken(_ code: String, completion: @escaping (Bool) -> Void) {
        // https://stackoverflow.com/a/75383148/641854 trim code string
        let cleanCode = code.trimmingCharacters(in: CharacterSet(charactersIn: "#_"))
        
        guard let clientId = clientId else {
            ReddLogger.shared.log(level: .error, message: "api key unavailable", category: .oAuth)
            completion(false)
            return

        }

        guard let url = URL(string: "https://www.reddit.com/api/v1/access_token") else {
            ReddLogger.shared.log(level: .error, message: "url unavailable", category: .oAuth)
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let payload = "grant_type=authorization_code&code=\(cleanCode)&redirect_uri=\(redirectPath)"
        request.httpBody = payload.data(using: .utf8)

        // HTTP Basic authentication
        let username = clientId
        let password = ""
        let loginData = "\(username):\(password)".data(using: .utf8)!
        let base64LoginData = loginData.base64EncodedString()
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")

        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let sessionError = error {
                ReddLogger.shared.log(level: .error, message: "Session error: \(sessionError).", category: .oAuth)
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                ReddLogger.shared.log(level: .error, message: "Response was not httpResponse.", category: .oAuth)
                completion(false)
                return
            }
            
            // TODO:
            guard (200...299).contains(httpResponse.statusCode) else {
                ReddLogger.shared.log(level: .error, message: "HTTP response code is not in the 2xx range \(httpResponse.statusCode).", category: .oAuth)
                completion(false)
                return
            }
            
            guard let responseData = data else {
                ReddLogger.shared.log(level: .error, message: "No response data.", category: .oAuth)
                completion(false)
                return
            }
            
            do {
                let redditResponse = try JSONDecoder().decode(RedditResponse.self, from: responseData)
                // TODO: validate?
                TokenManager.shared.saveTokens(response: redditResponse)
                DispatchQueue.main.async {
                    completion(true)
                }
            } catch {
                // TODO: vzlidate this
                ReddLogger.shared.log(level: .error, message: "\(error)", category: .oAuth)
                completion(false)
            }
        }

        // Start the network request
        task.resume()
    }
    
}
