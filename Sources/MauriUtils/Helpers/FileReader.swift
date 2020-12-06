//
//  FileReader.swift
//  MauriUtils
//
//  Created by Mauricio Chirino on 24/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import Foundation

public struct FileReader {
    /// Reads data from a specified file
    /// - Parameters:
    ///   - bundle: project's `bundle` where the file should be looked on. Defaults to the `.main` one
    ///   - filename: file's name without its extension
    ///   - type: file's extension. Defaults to `.json` type
    /// - Returns: If successful, raw data retrieved from the file. Otherwise (file not found) a `nil` value is returned
    public func read(in bundle: Bundle = .main,
                     from filename: String,
                     and type: FileExtension = .json) -> Data? {
        guard let file = bundle.url(forResource: filename, withExtension: type.rawValue) else {
            debugPrint("No file found for \(filename).\(type.rawValue)")
            return nil
        }

        return try! Data(contentsOf: file)
    }

    /// Reads data from a specified file
    /// - Parameter url: string URL representation where the file should be looked on
    /// - Returns: If successful, raw data retrieved from the file. Otherwise (file not found) a `nil` value is returned
    public func readAt(url: String) -> Data? {
        if !FileManager.default.fileExists(atPath: url) {
            NSLog("File doesn't exist: \(url)")
            return nil
        }

        return try! Data(contentsOf: URL(fileURLWithPath: url))
    }

    public func decodeJSON<T: Decodable>(in bundle: Bundle = .main, from filename: String) throws -> T {
        guard let validData = read(in: bundle, from: filename, and: .json) else {
            throw DecodeException.notFound
        }

        do {
            let validJSON = try JSONDecoder().decode(T.self, from: validData)

            return validJSON
        } catch {
            debugPrint("The file has a corrupted format")
            throw DecodeException.unparseable
        }
    }

    public func decodePlist<T: Decodable>(in bundle: Bundle = .main, from filename: String) throws -> T {
        guard let validData = read(in: bundle, from: filename, and: .plist) else {
            throw DecodeException.notFound
        }

        do {
            let validPlist = try PropertyListDecoder().decode(T.self, from: validData)

            return validPlist
        } catch {
            debugPrint("The file has a corrupted format")
            throw DecodeException.unparseable
        }
    }
}
