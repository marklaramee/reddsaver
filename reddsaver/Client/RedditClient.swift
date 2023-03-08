//
//  RedditClient.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/7/23.
//

import Foundation

class RedditClient {
    static let shared = RedditClient()
}

/*
 static let shared: ShopifyClient = {
     let instance = ShopifyClient()
     instance.client.cachePolicy = ShopifyClient.defaultCachePolicy
     return instance
 }()
 */





/*
 // Create a URL object
 guard let url = URL(string: "https://example.com/api/data") else {
     print("Invalid URL")
     return
 }

 // Create a URLRequest object with the URL
 var request = URLRequest(url: url)

 // Set the HTTP method to GET
 request.httpMethod = "GET"

 // Set the Authorization header with the bearer token
 let bearerToken = "your-bearer-token"
 request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")

 // Create a URLSessionDataTask to send the request
 let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
     // Handle the response here
     if let error = error {
         print("Error: \(error)")
         return
     }
     guard let data = data else {
         print("No data received")
         return
     }
     // Parse the data here
     print("Response data: \(data)")
 }

 // Start the data task
 task.resume()


 */

/*
 
 // create the URL for the API endpoint
 guard let url = URL(string: "https://example.com/api/endpoint") else {
     print("Invalid URL")
     return
 }

 // create the URLRequest with the URL and the HTTP method
 var request = URLRequest(url: url)
 request.httpMethod = "GET"

 // add the bearer token to the Authorization header
 let bearerToken = "YOUR_BEARER_TOKEN"
 request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")

 // create a URLSession to perform the request
 let session = URLSession.shared

 // create the task to perform the request
 let task = session.dataTask(with: request) { data, response, error in
     // handle the response
     guard error == nil else {
         print("Error: \(error!)")
         return
     }
     
     guard let data = data else {
         print("No data received")
         return
     }
     
     // handle the data
     print(String(data: data, encoding: .utf8)!)
 }

 // start the task
 task.resume()

 */
