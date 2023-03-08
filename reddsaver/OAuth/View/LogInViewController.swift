//
//  LogInViewController.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/8/23.
//

import UIKit

class LogInViewController: UIViewController {
        
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameButton: UIButton!
    
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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func usernameButtonTapped(_ sender: Any) {
        guard let user = usernameTextField.text else {
            // TODO: message user
            return
        }
        AuthenticationManager.shared.logInUser(username: user) { result in
            guard result == true else {
                // TODO: handle error
                return
            }
        }
    }

}
