//
//  DataSource.swift
//  
//
//  Created by Mauricio Chirino on 11/4/21.
//

import Foundation

/// Wrapper for dynamic data source object. Ideally to use MVVM presentation design pattern on `UITableView` and/or `UICollectionView`
public class DataSource<T>: NSObject {
    /// In memory generic data
    public var data: Dynamic<[T]>

    override public init() {
        data = Dynamic([])
    }
}
