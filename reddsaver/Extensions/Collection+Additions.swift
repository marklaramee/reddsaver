//
//  Collection+Additions.swift
//  reddsaver
//
//  Created by Mark Laramee on 3/3/23.
//

import Foundation


extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
