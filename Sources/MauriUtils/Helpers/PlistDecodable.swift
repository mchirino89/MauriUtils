//
//  PlistDecodable.swift
//  MauriUtils
//  
//  Created by Mauricio Chirino on 06/12/20.
//  Copyright © 2020 Mauricio Chirino. All rights reserved.
//

import Foundation

public struct PlistDecodable {
    /// Turns received data into a formatted JSON output
    /// - Parameters:
    ///   - input: raw data
    ///   - strategy: decoding strategy for JSON type. Defaults to `.useDefaultKeys` type
    /// - Throws: Possible `FileDecodableError` exception along the way
    /// - Returns: In case of success, a well formatted JSON output is produced
    public static func map<T: Decodable>(input: Data,
                                         with strategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) throws -> T {
        let decoder = PropertyListDecoder()

        do {
            return try decoder.decode(T.self, from: input)
        } catch let error {
            throw FileDecodableError.handleException(basedOn: error)
        }
    }
}
