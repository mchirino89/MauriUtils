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
        case .keyNotFound(let missingKey, let context):
            debugPrint("Missing key: \(missingKey.stringValue). \(context.debugDescription)")
            return .missingKey(missingKey)
        case .valueNotFound(let missingValue, let context):
            debugPrint("Missing value for: \(missingValue). \(context.debugDescription)")
            return .missingValue(missingValue)
        case .typeMismatch(let misMatch, let context):
            debugPrint("Wrong type for: \(misMatch). \(context.debugDescription)")
            return .wrongFormat(misMatch)
        case .dataCorrupted(let context):
            debugPrint("Data is corrupted. \(context.debugDescription).")
            return .dataCorrupted(context)
        @unknown default:
            debugPrint("Unhandled scenario")
            return .unknown
        }
    }
}
