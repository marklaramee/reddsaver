//
//  Logger.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/7/23.
//

import Foundation
import os

enum LogLevel: String {
    case info
    case warn
    case error
}

enum LogCategory: String {
    case oAuth = "OAuth Flow"
    case redditClient = "Reddit Client"
    case token
}

class ReddLogger {
    static let shared = ReddLogger()
    
    func log(level: LogLevel, message: String, category: LogCategory) {
        print("\(level.rawValue): \(message)")
        guard let identifier = Bundle.main.bundleIdentifier, level == .error else {
            return
        }
        let logger = Logger(subsystem: identifier, category: category.rawValue)
        logger.log("\(message)")
    }
}
