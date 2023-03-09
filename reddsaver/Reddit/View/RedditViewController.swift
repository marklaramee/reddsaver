//
//  RedditViewController.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/6/23.
//

import UIKit
import RxSwift
import RxRelay

class RedditViewController: UIViewController {
    
    let viewModel = RedditViewModel(client: RedditClient.shared)
    
    private let disposeBag = DisposeBag()
    
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
        
        viewModel.getPagedItems()
        
        viewModel.items.asObservable().subscribe(onNext: { [weak self] items in
            guard let root = items else {
                return
            }
                 
            // TODO: populate table
            
        }).disposed(by: disposeBag)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

            
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
    
    // let filterHuesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FilterHuesTableViewCell", for: indexPath) as?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
            // TODO: logger
            return UITableViewCell()
        }
        
        return cell
    }
}
