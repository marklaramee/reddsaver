//
//  OAuthViewController.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/3/23.
//

import UIKit
import WebKit

class OAuthViewController: UIViewController {
    
    private var webView = WKWebView(frame: .zero)
    
    let viewModel = OAuthViewModel()
    
    static func newInstance() -> OAuthViewController {
        let viewController = buildFromStoryboard("OAuth") as OAuthViewController
        return viewController
    }

    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self

        // TODO: move this conditional to root tab bar
        guard AuthenticationManager.shared.accessToken != nil else {
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
            ReddLogger.shared.log(level: .error, message: "Api key unavailable", category: .oAuth)
            return
        
        }

        /*
         /api/v1/authorize.compact? for a page that's friendlier to small screens (some people are reporting issues)
         try old.reddit.com for better error messages

         TODO: https://developer.apple.com/forums/thread/712074
         There's an open issue in XCode 16 with WKWebView that throws a threadsafe warning. No official resolution yet - 3/3/2023.
         */
        
        let oAuthUrl = "https://ssl.reddit.com/api/v1/authorize?client_id=\(clientId)&response_type=code&state=\(viewModel.validationString)&redirect_uri=\(viewModel.redirectPath)&duration=permanent&scope=history"
        guard let link = URL(string: oAuthUrl) else {
            handleError()
            return
        }
        
        let request = URLRequest(url: link)
        webView.load(request)
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        let navigationBar = UINavigationBar(frame: .zero)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        let navItem = UINavigationItem(title: "PERMISSIONS")
        navigationBar.setItems([navItem], animated: false)
        
        view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor)
        ])
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
                ReddLogger.shared.log(level: .error, message: "App validation string failed. This response was not verified as coming from this app.", category: .oAuth)
                handleError()
                return
            }
            
            guard let code = url.getRawQueryStringValue("code") else {
                handleError()
                decisionHandler(.cancel)
                return
            }
            viewModel.getAccessToken(code) { status in
                switch (status) {
                case true:
                    AuthenticationManager.shared.navigateToNextViewController(self.navigationController)
                case false:
                    self.handleError()
                }
            }
            decisionHandler(.cancel)
        }
    }
}
