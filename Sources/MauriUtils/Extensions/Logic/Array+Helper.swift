//
//  File.swift
//  
//
//  Created by Mauricio Chirino on 05/12/20.
//

import Foundation

public extension Array {
    /// Evaluates whether an array contains a single element
    var isSingleElement: Bool {
        return self.count == 1
    }

    /// Rearranges an item in the array from the given index into a new one
    mutating func rearrange(from: Int, to newIndex: Int) {
        guard from >= 0 && from < self.count, newIndex >= 0 && newIndex < self.count, from != newIndex else { return }
        insert(remove(at: from), at: newIndex)
    }
}
