//
//  RedditViewController.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/6/23.
//

import UIKit

class RedditViewController: UIViewController {
    
    let oAuthViewModel = OAuthViewModel()
    
    @IBOutlet weak var savedItemsTableView: UITableView!
    
    
    
    static func newInstance() -> RedditViewController {
        let viewController = buildFromStoryboard("Reddit") as RedditViewController
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

// MARK: UITableViewDataSource
extension RedditViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
            // TODO: logger
            return UITableViewCell()
        }
        
        return cell
    }
}
