//
//  FileDecodableError.swift
//  
//
//  Created by Mauricio Chirino on 06/12/20.
//

import Foundation

public enum FileDecodableError: Error {
    case missingKey(CodingKey)
    case missingValue(Any.Type)
    case wrongFormat(Any.Type)
    case dataCorrupted(DecodingError.Context)
    case unknown

    static func handleException(basedOn type: Error) -> FileDecodableError {
        guard let parsedError = type as? DecodingError else {
            debugPrint("Unhandled scenario")
            return .unknown
        }

        switch parsedError {
        case .keyNotFound(let missingkey, _):
            debugPrint("Missing key: \(missingkey.stringValue).")
            return .missingKey(missingkey)
        case .valueNotFound(let missingValue, let context):
            debugPrint("Missing value for: \(missingValue). \(context.debugDescription)")
            return .missingValue(missingValue)
        case .typeMismatch(let missMatch, let context):
            debugPrint("Wrong type for: \(missMatch). \(context.debugDescription)")
            return .wrongFormat(missMatch)
        case .dataCorrupted(let context):
            debugPrint("Data is corruputed. \(context.debugDescription).")
            return .dataCorrupted(context)
        @unknown default:
            debugPrint("Unhandled scenario")
            return .unknown
        }
    }
}
