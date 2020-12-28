//
//  JSONDecodable.swift
//  MauriUtils
//
//  Created by Mauricio Chirino on 24/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import Foundation

public struct JSONDecodable {
    /// Turns received data into a formatted JSON output
    /// - Parameters:
    ///   - input: raw data
    ///   - strategy: decoding strategy for JSON type. Defaults to `.useDefaultKeys` type
    ///   - dateDecoding: date decoding strategy. Defaults to `.iso8601` standard type
    /// - Throws: Possible `FileDecodableError` exception along the way
    /// - Returns: In case of success, a well formatted JSON output is produced
    public static func map<T: Decodable>(input: Data,
                                         with strategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                         dateDecoding: JSONDecoder.DateDecodingStrategy = .iso8601) throws -> T {
        let decoder = Decoder.buildJSONParser(for: strategy, dateDecoding: dateDecoding)

        do {
            return try decoder.decode(T.self, from: input)
        } catch let error {
            throw FileDecodableError.handleException(basedOn: error)
        }
    }
}
