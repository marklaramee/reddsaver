//
//  RedditClientMock.swift
//  reddsaverTests
//
//  Created by Mark Laramee on 3/8/23.
//

import Foundation
@testable import reddsaver

class RedditTestClient: RedditClient {
    var shouldReturnBoth = true
    
    override func getSavedItems(token: String, username: String, completion: @escaping (RedditResponse.Root?) -> Void) {
        guard shouldReturnBoth else {
            completion(nil)
            return
        }
        let post = buildPost()
        let comment = buildComment()
        // TODO: add pagination
        let reddData = RedditResponse.Data(after: nil, before: nil, children: [post, comment])
        let root = RedditResponse.Root(data: reddData)
        completion(root)
    }
    
    // TODO: refactor to same func if it makes sense
    private func buildPost() -> RedditResponse.Item {
        let itemData = buildItemData()
        return RedditResponse.Item(kind: RedditResponse.Types.t3.rawValue, data: itemData)
    }
    
    private func buildComment() -> RedditResponse.Item {
        let itemData = buildItemData()
        return RedditResponse.Item(kind: RedditResponse.Types.t1.rawValue, data: itemData)
    }
    
    private func buildItemData(withNils: Bool = false) -> RedditResponse.ItemData {
        let dummyUrl = "http://reddit.com"
        
        guard withNils == false else {
            return RedditResponse.ItemData(id: "5678", permalink: dummyUrl)
        }
        
        let dummySubreddit = "cats"
        let preview = buildPreview()
        
        return RedditResponse.ItemData(
            id: "abcd",
            author: "redditUser",
            body: "A bunch of text",
            link_id: "efgh",
            link_permalink: dummyUrl,
            name: "the name",
            permalink: dummyUrl,
            preview: preview,
            subreddit: dummySubreddit,
            subreddit_name_prefixed: "r/\(dummySubreddit)",
            subreddit_id: "ijkl",
            thumbnail: dummyUrl,
            thumbnail_width: 200,
            title: "The Title")
    }
    
    private func buildPreview() -> RedditResponse.Preview {
        let image = buildImage()
        return RedditResponse.Preview(enabled: true, images: [image])
    }
    
    
    private func buildImage() -> RedditResponse.Image {
        let info = buildImageInfo()
        return RedditResponse.Image(id: "1234", resolutions: [info], source: info)
    }
    
    
    private func buildImageInfo() -> RedditResponse.ImageInfo {
        return RedditResponse.ImageInfo(height: 200, url: "http://google.com", width: 200)
    }
}
