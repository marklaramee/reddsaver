//
//  RedditModel.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/8/23.
//

import Foundation

// TODO: convert to decodable
struct RedditResponse: Codable {
    struct Root: Codable {
        var data: Data
    }
    
    struct Data: Codable {
        var after: String?
        var before: String?
        var children: [Item]?
    }
    
    struct Item: Codable {
        var kind: String  // TODO: convert to enum https://www.reddit.com/dev/api#listings
        var data: ItemData
    }
    
    struct ItemData: Codable {
        var id: String
        var author: String?
        var body: String?
        var link_id: String?
        var link_permalink: String?
        var name: String?
        var permalink: String
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
        var images: [Image]?
    }
    
    struct Image: Codable {
        var id: String?
        var resolutions: [ImageInfo]?
        var source: ImageInfo?
        // TODO: var variants[xxx]?
    }
    
    struct ImageInfo: Codable {
        var height: Int?
        var url: String?
        var width: Int?
    }
    
    enum Types: String {
        case t1 // "Comment"
        case t2 // "Account"
        case t3 // "Link"
        case t4 // "Message"
        case t5 // "Subreddit"
        case t6 // "Award"
    }
}



/*
 struct Stack<Element> {
 var items: [Element] = []
 mutating func push(_ item: Element) {
 items.append(item)
 }
 
 mutating func pop() -> Element {
 return items.removeLast()
 }
 }
 
 var stackSt = Stack<String>()
 */
