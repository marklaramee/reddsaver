//
//  RedditViewController.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/6/23.
//

import UIKit

class RedditViewController: UIViewController {
    
    let oAuthViewModel = OAuthViewModel()
    
    static func newInstance() -> RedditViewController {
        let viewController = buildFromStoryboard("Core") as RedditViewController
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
 
        // TODO: reinstate
        RedditClient.shared.getPagedItems()
            
    }

}
