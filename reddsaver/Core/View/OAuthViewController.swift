//
//  View1ViewController.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/3/23.
//

import UIKit
import WebKit

class OAuthViewController: UIViewController {
    
    private var webView = WKWebView(frame: .zero)
    
    let viewModel = OAuthViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        // validationString = String.random()

        // TODO: move this conditional to root tab bar
        guard viewModel.oAuthToken != nil else {
            getAuthCode()
            return
        }
    }
    
    /*
     https://github.com/reddit-archive/reddit/wiki/OAuth2
     https://github.com/reddit-archive/reddit/wiki/OAuth2-iOS-Example
     https://medium.com/posts-from-emmerge/implementing-an-oauth2-login-flow-in-wkwebview-de74e23fe9ee#.3frp7nygm
    */
    private func getAuthCode() {
        guard let clientId = viewModel.clientId else {
            handleError()
            print("ml:  api key unavailable")
            return
        
        }

        /*
         /api/v1/authorize.compact? for a page that's friendlier to small screens (some people are reporting issues)
         try old.reddit.com for better error messages
         */
        
        
        let oAuthUrl = "https://ssl.reddit.com/api/v1/authorize?client_id=\(clientId)&response_type=code&state=\(viewModel.validationString)&redirect_uri=\(viewModel.redirectPath)&duration=permanent&scope=history"
        guard let link = URL(string: oAuthUrl) else {
            handleError()
            return
        }
        let request = URLRequest(url: link)
        self.webView.load(request)
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.webView)
        
        let navigationBar = UINavigationBar(frame: .zero)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        let navItem = UINavigationItem(title: "PERMISSIONS")
        navigationBar.setItems([navItem], animated: false)
        
        self.view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            navigationBar.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            navigationBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.webView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.webView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.webView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor)
        ])
            
    }
    
    // https://github.com/reddit-archive/reddit/wiki/OAuth2#retrieving-the-access-token
    // https://stackoverflow.com/a/75383148/641854 trim code string
    func getAccessToken(_ code: String) {
        let cleanCode = code.trimmingCharacters(in: CharacterSet(charactersIn: "#_"))
        guard let clientId = viewModel.clientId else {
            print("ML:  api key unavailable")
            handleError()
            return

        }

        guard let url = URL(string: "https://www.reddit.com/api/v1/access_token") else {
            handleError()
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let payload = "grant_type=authorization_code&code=\(cleanCode)&redirect_uri=\(viewModel.redirectPath)"
        request.httpBody = payload.data(using: .utf8)

        // HTTP Basic authentication
        let username = clientId
        let password = ""
        let loginData = "\(username):\(password)".data(using: .utf8)!
        let base64LoginData = loginData.base64EncodedString()
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")

        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("ML: Error: \(error!)")
                self.handleError()
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("ML: response was not httpResponse")
                self.handleError()
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("ML: Error: HTTP response code is not in the 2xx range \(httpResponse.statusCode)")
                self.handleError()
                return
            }
            
            // Check if there is any response data
            guard let responseData = data else {
                self.handleError()
                print("ML: Error: No response data")
                return
            }
            
            do {
                let redditResponse = try JSONDecoder().decode(RedditResponse.self, from: responseData)
                // TODO: send to storage and navigate
                print("ML: acccess_token \(redditResponse.access_token)")
                print("ML: refresh_token \(redditResponse.refresh_token)")
            } catch {
                self.handleError()
                print("ML: Error: \(error)")
            }
        }

        // Start the network request
        task.resume()
    }
    
    private func handleError() {
        // TODO:
    }
}

// MARK: WKNavigationDelegate
extension OAuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url{
            guard url.absoluteString.hasPrefix("reddsaver") else {
                decisionHandler(.allow)
                return
            }
            
            // ensure this is a response from this app  
            guard let validationState = url.getRawQueryStringValue("state"),
                  validationState == self.viewModel.validationString else {
                print("ML: validation failure")
                handleError()
                return
            }
            
            guard let code = url.getRawQueryStringValue("code") else {
                handleError()
                decisionHandler(.cancel)
                return
            }
            getAccessToken(code)
            decisionHandler(.cancel)
        }
    }
}
