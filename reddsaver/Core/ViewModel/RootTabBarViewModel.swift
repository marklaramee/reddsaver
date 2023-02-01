//
//  RootTabBarViewModel.swift
//  reddsaver
//
//  Created by Mark Laramee on 2/1/23.
//

import Foundation
import UIKit

class RootTabBarViewModel {

//    let storage = UserStorage.shared
//    let iOSVersion = UIDevice.current.systemVersion.components(separatedBy: ".")[0]
//    var updateTriggered = false
//
//    func checkAppVersion(immediateVersion configImmediateVersion: AppVersion, flexibleVersion configFlexibleVersion: AppVersion) -> UpdateType {
//        if !updateTriggered {
//            guard let currentVersion = Utilities.currentAppVersion else {
//                Logger.shared.error(message: "Unable to get current app version")
//                return UpdateType.none
//            }
//            if currentVersion < configImmediateVersion {
//                return UpdateType.immediate
//            } else {
//                if currentVersion < configFlexibleVersion {
//                    guard let lastVersionString: String = storage.readGlobalValue(forKey: .lastFlexibleVersion) else {
//                        Logger.shared.info(
//                            message: "Flexible update fired. No version string was available in UserStorage.",
//                            keyValues: ["currentVersion": currentVersion.toString(), "configVersion": configFlexibleVersion.toString()]
//                        )
//                        storage.saveGlobalValue(forKey: .lastFlexibleVersion, value: configFlexibleVersion.toString())
//                        return UpdateType.flexible
//                    }
//                    do {
//                        let lastVersion = try AppVersion(fromString: lastVersionString)
//                        if configFlexibleVersion > lastVersion {
//                            Logger.shared.info(
//                                message: "Flexible update fired. The new version is greater than the version from UserStorage.",
//                                keyValues: ["currentVersion": currentVersion.toString(), "configVersion": configFlexibleVersion.toString(), "UserStorage version": lastVersion.toString()]
//                            )
//                            storage.saveGlobalValue(forKey: .lastFlexibleVersion, value: configFlexibleVersion.toString())
//                            return UpdateType.flexible
//                        }
//                    } catch {
//                        Logger.shared.error(message: "Could not convert lastVersionString to AppVersion", keyValues: ["lastVersionString": lastVersionString, "error": error.localizedDescription])
//                    }
//                }
//            }
//        }
//
//        return UpdateType.none
//    }
}

enum UpdateType {
    case none
    case flexible
    case immediate
}

