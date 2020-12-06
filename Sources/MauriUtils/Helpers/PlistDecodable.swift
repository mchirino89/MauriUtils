//
//  PlistDecodable.swift
//  
//
//  Created by Mauricio Chirino on 06/12/20.
//

import Foundation

public struct PlistDecodable {
    /// Turns received data into a formatted JSON output
    /// - Parameters:
    ///   - input: raw data
    ///   - strategy: decoding strategy for JSON type. Defaults to `.useDefaultKeys` type
    /// - Throws: Possible `JSONDecodableError` exception along the way
    /// - Returns: In case of success, a well formatted JSON output is produced
    public static func map<T: Decodable>(input: Data,
                                         with strategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) throws -> T {
        let decoder = PropertyListDecoder()

        do {
            return try decoder.decode(T.self, from: input)
        } catch DecodingError.keyNotFound(let missingkey, _) {
            debugPrint("Missing key: \(missingkey.stringValue).")
            throw FileDecodableError.missingKey(missingkey)
        } catch DecodingError.valueNotFound(let missingValue, let context) {
            debugPrint("Missing value for: \(missingValue). \(context.debugDescription)")
            throw FileDecodableError.missingValue(missingValue)
        } catch DecodingError.typeMismatch(let missMatch, let context) {
            debugPrint("Wrong type for: \(missMatch). \(context.debugDescription)")
            throw FileDecodableError.wrongFormat(missMatch)
        } catch DecodingError.dataCorrupted(let context) {
            debugPrint("Data is corrupted. \(context.debugDescription).")
            throw FileDecodableError.dataCorrupted(context)
        }
    }
}
