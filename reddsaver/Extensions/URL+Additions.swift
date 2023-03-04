//
//  URL+Additions.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/3/23.
//

import Foundation

extension URL {
    func getRawQueryStringValue(_ name: String) -> String? {
        // TODO: validation, throw error
        
        let components = self.absoluteString.components(separatedBy: "?")
        guard components.count == 2 else {
            return nil
        }

        let qstring: String = components[1]
        let qstringNVPairs = qstring.components(separatedBy:  "&")

        guard let nvPair = qstringNVPairs.first(where: { $0.range(of: "\\b\(name)\\b", options: .regularExpression) != nil })  else {
            return nil
        }

        let nameValue = nvPair.components(separatedBy:  "=")
        guard nameValue.count == 2 else {
            return nil
        }

        let value: String = nameValue[1]
        return value
    }
}
