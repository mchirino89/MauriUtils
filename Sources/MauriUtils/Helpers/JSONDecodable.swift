//
//  JSONDecodable.swift
//  MauriUtils
//
//  Created by Mauricio Chirino on 24/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import Foundation

// This could also be a protocol
public struct JSONDecodable {
    /// Turns received data into a formatted JSON output
    /// - Parameters:
    ///   - input: raw data
    ///   - strategy: decoding strategy for JSON type. Defaults to `.useDefaultKeys` type
    /// - Throws: Possible `JSONDecodableError` exception along the way
    /// - Returns: In case of success, a well formatted JSON output is produced 
    public static func map<T: Decodable>(input: Data,
                                         with strategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = strategy
        do {
            return try decoder.decode(T.self, from: input)
        } catch DecodingError.keyNotFound(let missingkey, _) {
            NSLog("Missing key: \(missingkey.stringValue).")
            throw FileDecodableError.missingKey(missingkey)
        } catch DecodingError.valueNotFound(let missingValue, let context) {
            NSLog("Missing value for: \(missingValue). \(context.debugDescription)")
            throw FileDecodableError.missingValue(missingValue)
        } catch DecodingError.typeMismatch(let missMatch, let context) {
            NSLog("Wrong type for: \(missMatch). \(context.debugDescription)")
            throw FileDecodableError.wrongFormat(missMatch)
        } catch DecodingError.dataCorrupted(let context) {
            NSLog("Data is corruputed. \(context.debugDescription).")
            throw FileDecodableError.dataCorrupted(context)
        }
    }
}

