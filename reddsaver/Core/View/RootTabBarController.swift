//
//  RootTabBarController.swift
//  reddsaver
//
//  Created by Mark Laramee on 2/1/23.
//

import UIKit


class RootTabBarController: UITabBarController {

    @IBOutlet weak var rootTabBar: UITabBar!

    // MARK: - Init
    static func newInstance() -> RootTabBarController {
        let viewController = buildFromStoryboard("Core") as RootTabBarController
        return viewController
    }
    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Nav bar actions
    @objc func backToCartPressed() {

    }
}
