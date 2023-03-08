//
//  Nav1Controller.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/6/23.
//

import UIKit

class OAuthNavigationController: UINavigationController {
    // MARK: - Init
    static func newInstance() -> OAuthNavigationController {
        let viewController = buildFromStoryboard("OAuth") as OAuthNavigationController
        return viewController
    }
    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
