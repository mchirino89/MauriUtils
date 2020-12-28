//
//  FileConstants.swift
//  
//
//  Created by Mauricio Chirino on 06/12/20.
//

import Foundation

/// Possible exceptions to be handled whenever something goes wrong decoding a file
public enum DecodeException: Error {
    case notFound
    case unparseable
}

/// File types supported for decoders/readers
public enum FileExtension: String {
    case plist
    case json
}
