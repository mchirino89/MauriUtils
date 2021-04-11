//
//  Dynamic.swift
//  
//
//  Created by Mauricio Chirino on 11/4/21.
//

import Foundation

/// Wrapper that notifies whenever modifications happen to the stored value
public final class Dynamic<T> {
    public typealias Listener = (T) -> Void

    /// Stored listener reference.
    public var listener: Listener?

    /// Generic stored value
    public var value: T {
        didSet {
            listener?(value)
        }
    }

    /// Default init
    /// - Parameter value: generic value to be stored
    public init(_ value: T) {
        self.value = value
    }

    /// Propagates an action whenever an update ocurrs
    /// - Parameter listener: closure action to be executed after stored value has been modified
    public func update(_ listener: Listener?) {
        self.listener = listener

        listener?(value)
    }
}
