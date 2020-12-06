//
//  FileConstants.swift
//  
//
//  Created by Mauricio Chirino on 06/12/20.
//

import Foundation

public enum DecodeException: Error {
    case notFound
    case unparseable
}

public enum FileExtension: String {
    case plist
    case json
}
