//
//  SyntacticSugar.swift
//
//
//  Created by Mauricio Chirino on 14/12/20.
//

import Foundation

/// Performs an update on main thread safely
/// - Parameter closure: closure with update execution
public func executeMainThreadUpdate(using closure: @escaping () -> Void) {
    // If we're already on the main thread, execute it directly
    if Thread.isMainThread {
        closure()
    } else {
        DispatchQueue.main.async(execute: closure)
    }
}
