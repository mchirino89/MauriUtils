//
//  Array+Equatable.swift
//  
//
//  Created by Mauricio Chirino on 05/12/20.
//

import Foundation

public extension Array where Element: Equatable {
    /// Merges a collection into another with unique elements
    mutating func mergeElements<C: Collection>(newElements: C) where C.Iterator.Element == Element {
        let filteredList = newElements.filter({ !self.contains($0) })
        self.append(contentsOf: filteredList)
    }

    /// Removes the element giving from the array, should it exist in it.
    func removing(_ obj: Element) -> [Element] {
        return filter { $0 != obj }
    }
}
