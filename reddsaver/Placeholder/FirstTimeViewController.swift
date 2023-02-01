//
//  FirstTimeViewController.swift
//  reddsaver
//
//  Created by Mark Laramee on 1/17/23.
//

import UIKit

class FirstTimeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


//static func newInstance() -> AccountSettingsViewController {
//    let viewController = buildFromStoryboard("Account") as AccountSettingsViewController
//    return viewController
//}

//import UIKit
//
//class AccountNavigationController: UINavigationController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.viewControllers = [AccountViewController.newInstance()]
//    }
//}
//


//// MARK: - Init
//static func newInstance(popupContentDelegate: PopupContentDelegate? = nil) -> PopupViewController {
//    let storyboard = UIStoryboard.init(name: "Popup", bundle: nil)
//    // swiftlint:disable force_cast
//    let viewController = storyboard.instantiateViewController(withIdentifier:
//        "PopupViewController") as! PopupViewController
//    // swiftlint:enable force_cast
//    viewController.popupContentDelegate = popupContentDelegate
//
//    return viewController
//}
//private init() {
//    super.init(nibName: nil, bundle: nil)
//}
//required init?(coder aDecoder: NSCoder) {
//    super.init(coder: aDecoder)
//}


//func openCheckout(url: URL, checkoutViewModel: CheckoutViewModel) {
//    let webController = CheckoutWKWebViewController(url: url, checkoutId: checkoutViewModel.id, presentedFromViewController: self, accessToken: AuthenticationManager.shared.accessToken, checkoutStatusDelegate: self, checkoutViewModel: checkoutViewModel)
//    webController.modalPresentationStyle = .fullScreen
//    self.present(webController, animated: true, completion: nil)
//}


//func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//    guard let winScene = (scene as? UIWindowScene) else { return }
//
//    // Create main app window with initial view controller
//    window = UIWindow(windowScene: winScene)
//
//    if OnboardingController.shared.isOnboardingComplete {
//        window?.rootViewController = RootTabBarController.newInstance()
//        window?.makeKeyAndVisible()
//    } else {
//        window?.rootViewController = getLaunchScreen()
//        window?.makeKeyAndVisible()
//
//        // wait for remote configs so we know which screen to load
//        DispatchQueue.main.async {
//            let semaphore = DispatchSemaphore(value: 0)
//
//            Configuration.shared.waitForRemoteConfigurations { _ in
//                self.launchOnboarding()
//                semaphore.signal()
//            }
//
//            let timeout = DispatchTime.now() + .seconds(self.remoteConfigurationTimeoutInSeconds)
//            if semaphore.wait(timeout: timeout) == .timedOut {
//                self.launchOnboarding()
//                semaphore.signal()
//            }
//        }
//    }
//
//    // AppDelegate maintains link to the main window object
//    window?.makeKeyAndVisible()
//
//    SceneDelegate.shared = self
//
//    // Tint styling for the entire app
//    UINavigationBar.appearance().tintColor = UIColor.Allbirds.black
//    UITabBar.appearance().tintColor = UIColor.Allbirds.black
//
//    // Font styling for the navigation bar
//    let attributes: [NSAttributedString.Key: Any] = [
//        .foregroundColor: UIColor.Allbirds.black,
//        .font: UIFont(allbirdsFontStyle: .bold, size: AccessibilityUtil.shared.maxFontSize(12)),
//        .kern: LetterSpacing.allCaps.rawValue
//    ]
//    UINavigationBar.appearance().titleTextAttributes = attributes
//
//    // Workaround for SceneDelegate continueUserActivity not getting called on cold start
//    if let userActivity = connectionOptions.userActivities.first {
//        BranchScene.shared().scene(scene, continue: userActivity)
//    }
//}
