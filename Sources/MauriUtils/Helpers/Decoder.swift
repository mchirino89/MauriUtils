//
//  Decoder.swift
//  
//
//  Created by Mauricio Chirino on 28/12/20.
//

import Foundation

struct Decoder {
    /// Assembles custom `JSONDecoder` object
    /// - Parameters:
    ///   - keyDecoding: decoding strategy for JSON type
    ///   - dateDecoding: date decoding strategy
    /// - Returns: customized `JSONDecoder` object
    static func buildJSONParser(for keyDecoding: JSONDecoder.KeyDecodingStrategy,
                                dateDecoding: JSONDecoder.DateDecodingStrategy) -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecoding
        decoder.dateDecodingStrategy = dateDecoding

        return decoder
    }
}
