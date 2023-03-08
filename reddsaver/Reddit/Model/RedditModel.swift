//
//  RedditModel.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/8/23.
//

import Foundation

struct Reddit {
    struct Root: Decodable {
        var data: Reddit.Data
    }
    
    struct Data: Codable {
        var after: String?
        var before: String?
        var children: [Item]?
    }
    
    struct Item: Codable {
        var kind: String?  // TODO: convert to enum https://www.reddit.com/dev/api#listings
        var data: ItemData?
    }
    
    struct ItemData: Codable {
        var id: String?
        var author: String?
        var permalink: String?
        var preview: Preview?
        var subreddit: String?
        var subreddit_name_prefixed: String?
        var subreddit_id: String?
        var thumbnail: String?
        var thumbnail_width: Int?
        var title: String?
        
    }
    
    struct Preview: Codable {
        var enabled: Bool?
        var images: [Image]
    }
    
    struct Image: Codable {
        var resolutions: [Resolution]?
    }
    
    struct Resolution: Codable {
        var height: Int?
        var url: String?
        var width: Int?
    }
    
}
