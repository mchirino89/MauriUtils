//
//  Decodable+File.swift
//  
//
//  Created by Mauricio Chirino on 28/12/20.
//

import Foundation

public extension Decodable {
    /// Decodes JSON object from a given file
    /// - Parameters:
    ///   - fileName: local file to be decoded
    ///   - keyDecoding: decoding strategy for JSON type. Defaults to `.useDefaultKeys` type
    ///   - dateDecoding: date decoding strategy. Defaults to `.iso8601` standard type
    ///   - bundle: project's `bundle` where the file should be looked on. Defaults to the `.main` one
    /// - Throws: Possible `DecodeException` exception along the way if the file isn't found
    /// - Returns: decoded object if successful 
    static func JSONFromFile(named fileName: String,
                             keyDecoding: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                             dateDecoding: JSONDecoder.DateDecodingStrategy = .iso8601,
                             in bundle: Bundle = .main) throws -> Self {
        guard let url = bundle.url(forResource: fileName, withExtension: FileExtension.json.rawValue) else {
            throw DecodeException.notFound
        }

        let data = try Data(contentsOf: url)
        let decoder = Decoder.buildJSONParser(for: keyDecoding, dateDecoding: dateDecoding)

        return try decoder.decode(self, from: data)
    }
}
