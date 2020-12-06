//
//  FileReader.swift
//  MauriUtils
//
//  Created by Mauricio Chirino on 24/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import Foundation

public enum FileExtension: String {
    case text = "txt"
    case json

    var value: String {
        return self.rawValue
    }
}

public struct FileReader {
    /// Reads data from a specified file
    /// - Parameters:
    ///   - bundle: project's `bundle` where the file should be looked on. Defaults to the `.main` one
    ///   - filename: file's name without its extension
    ///   - type: file's extension. Defaults to `.json` type
    /// - Returns: If successful, raw data retrieved from the file. Otherwise (file not found) a `nil` value is returned
    public static func read(in bundle: Bundle = .main,
                            from filename: String,
                            and type: FileExtension = .json) -> Data? {
        guard let file = bundle.url(forResource: filename, withExtension: type.value) else {
            NSLog("No file found for \(filename).\(type.value)")
            return nil
        }

        return try! Data(contentsOf: file)
    }

    /// Reads data from a specified file
    /// - Parameter url: string URL representation where the file should be looked on
    /// - Returns: If successful, raw data retrieved from the file. Otherwise (file not found) a `nil` value is returned
    public static func readAt(url: String) -> Data? {
        if !FileManager.default.fileExists(atPath: url) {
            NSLog("File doesn't exist: \(url)")
            return nil
        }

        return try! Data(contentsOf: URL(fileURLWithPath: url))
    }
}
