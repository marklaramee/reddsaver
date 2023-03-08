//
//  View1ViewController.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/6/23.
//

import UIKit

class View1ViewController: UIViewController {
    
    let oAuthViewModel = OAuthViewModel()
    
    static func newInstance() -> View1ViewController {
        let viewController = buildFromStoryboard("Core") as View1ViewController
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

// MARK: AuthenticationDelegate
extension View1ViewController: AuthenticationDelegate {
    func loadNextViewController(_ nextVC: UIViewController?) {
        guard let loadingVC = nextVC else {
            return
        }
        navigationController?.pushViewController(loadingVC, animated: true)
    }
}
