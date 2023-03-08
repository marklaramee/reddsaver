//
//  RedditNavigationController.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/8/23.
//

import UIKit

class RedditNavigationController: UINavigationController {

    let redditVC = RedditViewController.newInstance()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewControllers = [redditVC]
    }

}
