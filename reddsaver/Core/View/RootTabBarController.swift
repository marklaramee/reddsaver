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
    let viewModel = RootTabBarViewModel()
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
        
        guard let token = viewModel.oAuthToken else {
            launchOAuth()

            return
        }

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
    

    private func launchOAuth() {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            print("ml:  api key unavailable")
            return
        
        }
        
        print("ml:  api \(apiKey)")
        
        let ACCESS_TOKEN_URL = "https://www.reddit.com/api/v1/access_token"
            let GRANT_TYPE = "https://oauth.reddit.com/grants/installed_client"
            let DONT_TRACK = "DO_NOT_TRACK_THIS_DEVICE"
            let timeout = 15
            let uncodedClientIDAndPassword = "\(apiKey):"  // TODO: remvoe force unwrap
            let encodedClientIDAndPassword = uncodedClientIDAndPassword.toBase64()
            let authStr = "Basic \(encodedClientIDAndPassword)"
            guard let serviceUrl = URL(string: ACCESS_TOKEN_URL) else {
                // completionHandler(nil)
                let rrr = apiKey
                return
            }
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue(authStr, forHTTPHeaderField: "Authorization")

        // Important Edit: You need to manually make the parameters, don't make a String dictionary and convert it to JSON and then sending it. Reddit doesn't accept that.
            let param = "grant_type=\(GRANT_TYPE)&device_id=\(DONT_TRACK)"
            let data = param.data(using: .utf8)
            request.httpBody = data
            // timeout
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = TimeInterval(timeout)
            config.timeoutIntervalForResource = TimeInterval(timeout)
            let session = URLSession(configuration: config)

            session.dataTask(with: request) { (data, response, error) in
                if data != nil {
                    do {
                        if let json = (try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] {
                            // self.accessToken = json["access_token"] as? String // TODO: stuff
                            let accessToken = json["access_token"] as? String
                            let rituri = 1
                            print("ml: \(accessToken)")
                        } else {
                            // self.accessToken = nil
                            let yyyy = 1
                            
                        }
                    }
                }
                let oierut = 1;
                // completionHandler(self.getAccessToken())
            }.resume()
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
