//
//  RootTabBarController.swift
//  reddsaver
//
//  Created by Mark Laramee on 2/1/23.
//

import UIKit


class RootTabBarController: UITabBarController {

    @IBOutlet weak var rootTabBar: UITabBar!
    

    //let appConfiguration = Configuration.shared
    
    // Maintains relationship of tab.tag to UIViewController[index] -> tag:index
    //var tabBarItemToViewControllerReference: [RootTabTag: Int] = [:]

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
        
        

//        rootTabBar.tintColor = UIColor.Allbirds.black
//
//        // Style each tab
//        rootTabBar.items?.forEach { tabBarItem in
//            let attributes: [NSAttributedString.Key: Any] = [
//                .font: UIFont.init(allbirdsFontStyle: .bold, size: 10),
//                .kern: LetterSpacing.regular.rawValue
//            ]
//            tabBarItem.setTitleTextAttributes(attributes, for: .normal)
//
//            // Accessibility (set this before we adjust the title)
//            tabBarItem.accessibilityLabel = tabBarItem.title
//
//            // TabBarItem doesn't seem to respect kern. As a workaround, we add unicode
//            // value for 1/5 em spacing http://jkorpela.fi/chars/spaces.html
//            tabBarItem.title = Array(tabBarItem.title ?? "").map { String($0) + "\u{2009}" }.joined()
//        }

//        resetTabToViewReference()
//        handleAppConfiguration()

//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(handleAppConfiguration),
//            name: .appConfiguration,
//            object: nil
//        )
//
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(handleUpdateTab(_:)),
//            name: .updateTab,
//            object: nil
//        )
    }
    
    
    
    // MARK: - Nav bar actions
    @objc func backToCartPressed() {
//        let alertController = UIAlertController(title: "End Checkout?", message: "Are you sure you want to close checkout?", preferredStyle: .alert)
//
//        let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
//            // Make sure the cart is updated. This fixes issue with discount code staying when it
//            // should disappear
//            let notification = Notification(name: Notification.Name.CartControllerCheckoutModelChange)
//            NotificationQueue.default.enqueue(notification, postingStyle: .asap)
//
//            self.dismiss(animated: true, completion: nil)
//        }
//        let noAction = UIAlertAction(title: "No", style: .cancel) { _ in
//        }
//
//        alertController.addAction(yesAction)
//        alertController.addAction(noAction)
//        self.present(alertController, animated: true, completion: nil)
    }

//    private func resetTabToViewReference() {
//        tabBarItemToViewControllerReference = [:]
//        if let controllers = self.viewControllers {
//            for (index, controller) in controllers.enumerated() {
//                switch controller {
//                case is DiscoverNavigationController:
//                    tabBarItemToViewControllerReference[RootTabTag.discover] = index
//                case is ShopNavigationController:
//                    tabBarItemToViewControllerReference[RootTabTag.shop] = index
//                case is AccountNavigationController:
//                    tabBarItemToViewControllerReference[RootTabTag.account] = index
//                default:
//                    break
//                }
//            }
//        }
//    }

//    private func updateTabView(forTag tag: RootTabTag?) {
//        // Keep the discover view translucense for the tab bar, the other views
//        // need a solid background
//        if let rootTabTag = tag,
//           rootTabTag == .discover {
//            rootTabBar.backgroundColor = UIColor.clear
//        } else {
//            rootTabBar.backgroundColor = UIColor.Allbirds.white
//        }
//    }

//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//
//        if let indexOfItem = tabBar.items?.firstIndex(of: item) {
//            updateTabView(
//                forTag: tabBarItemToViewControllerReference.first(
//                    where: { $1 == indexOfItem })?.key)
//        }
//
//        // Capture the tab select for analytics
//        Analytics.logEvent(NavigationAnalyticsEvents.click,
//                           parameters: [
//                            NavigationAnalyticsParams.bottomNav: item.title
//        ])
//    }

//    @objc private func handleUpdateTab(_ notification: NSNotification) {
//        guard let rootTabTag = notification.userInfo?["rootTabTag"] as? RootTabTag, let index = tabBarItemToViewControllerReference[rootTabTag] else {
//            Logger.shared.error(message: "Notification to update root tab bar received with incorrect information.", keyValues: ["userInfo": "\(String(describing: notification.userInfo))"])
//            return
//        }
//
//        updateTabView(forTag: rootTabTag)
//
//        if let shopViewController = viewControllers?[index] as? ShopNavigationController, let defaultTabTitle = notification.userInfo?["title"] as? String {
//            shopViewController.setDefaultTab(withTitle: defaultTabTitle)
//        }
//
//        if let discoverNavController = viewControllers?[index] as? DiscoverNavigationController {
//            discoverNavController.sendToTopOfDiscoverFeed()
//        }
//
//        selectedIndex = index
//    }

//    @objc private func handleAppConfiguration() {
//        hideTabsByConfiguration()
//        DispatchQueue.global(qos: .utility).async {
//            let updateType = self.viewModel.checkAppVersion(
//                immediateVersion: self.appConfiguration.configurations.immediateUpdateVersion,
//                flexibleVersion: self.appConfiguration.configurations.flexibleUpdateVersion
//            )
//            switch updateType {
//            case .immediate:
//                self.immediateUpdate()
//            case .flexible:
//                self.flexibleUpdate()
//            default: break
//            }
//        }
//    }

//    private func flexibleUpdate() {
//        viewModel.updateTriggered = true
//        DispatchQueue.main.async {
//            let alert = UIAlertController(title: "Time to Update!", message: "Update the app for the latest, greatest version.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: NSLocalizedString("No thanks", comment: "Declined flexible update"), style: .cancel, handler: { _ in
//                Logger.shared.info(message: "User declined to update", keyValues: ["iOS version": self.viewModel.iOSVersion])
//            }))
//            alert.addAction(UIAlertAction(title: NSLocalizedString("Update", comment: "Accepted flexible update"), style: .default, handler: { _ in
//                self.launchAppStore()
//            }))
//            self.present(alert, animated: true, completion: nil)
//        }
//    }

//    private func immediateUpdate() {
//        viewModel.updateTriggered = true
//        DispatchQueue.main.async {
//            let alert = UIAlertController(title: "Time to Update!", message: "In order to use the app, you'll need to update to the latest, greatest version.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: NSLocalizedString("Update", comment: "Accepted immediate update"), style: .default, handler: { _ in
//                self.launchAppStore()
//                self.immediateUpdate()
//            }))
//            self.present(alert, animated: true, completion: nil)
//        }
//    }

//    private func launchAppStore() {
//        let storePath = "https://apps.apple.com/us/app/allbirds/id1495911336"
//        guard let url = URL(string: storePath) else {
//            Logger.shared.error(message: "Could not get URL for app store")
//            return
//        }
//        DispatchQueue.main.async {
//            UIApplication.shared.open(url, options: [:], completionHandler: {(success: Bool) in
//                if success {
//                    Logger.shared.info(message: "Update link successful")
//                } else {
//                    Logger.shared.error(message: "Unable to link to app store")
//                }
//            })
//        }
//    }

//    private func hideTabsByConfiguration() {
//        DispatchQueue.main.async {
//            if !self.appConfiguration.configurations.featureFlags.accountEnabled {
//                self.removeViewByTab(tab: RootTabTag.account)
//            }
//        }
//    }

//    private func removeViewByTab(tab: RootTabTag) {
//        if let viewIndex = tabBarItemToViewControllerReference[tab],
//        let controllers = viewControllers,
//        viewIndex < controllers.count {
//            viewControllers?.remove(at: viewIndex)
//            resetTabToViewReference()
//        } else {
//            Logger.shared.warn(message: "Unable satisfy requirements to remove tabs", keyValues: ["tab index": "\(tab)"])
//        }
//    }
}

//extension Notification.Name {
//    static let updateTab = Notification.Name("updateTab")
//}

enum RootTabTag: Int {
    case discover = 0
    case shop = 1
    case account = 2

    var description: String {
        switch self {
        case .discover: return "Discover"
        case .shop: return "Browse"
        case .account: return "Account"
        }
    }
}
