//
//  OAuthModel.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/3/23.
//

import Foundation

struct RedditResponse: Codable {
    var expires_in: Int
    var token_type: String
    var access_token: String
    var refresh_token: String
    var scope: String
}
