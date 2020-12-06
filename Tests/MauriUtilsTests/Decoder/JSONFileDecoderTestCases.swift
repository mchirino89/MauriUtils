//
//  File.swift
//  
//
//  Created by Mauricio Chirino on 05/12/20.
//

import XCTest
@testable import MauriUtils

final class JSONFileDecoderTestCases: XCTestCase {
    var fileReader: FileReader!

    override func setUp() {
        super.setUp()
        // Given
        fileReader = FileReader()
    }

    override func tearDown() {
        super.tearDown()
        fileReader = nil
    }

    func testJSONDecodingFromAFileInBundle() {
        // When
        do {
            let decodedFile: TestUser = try fileReader.decodeJSON(in: Bundle(for: Self.self), from: "validJSON")
            XCTAssertEqual(decodedFile.name, "Mauricio Chirino")
        } catch let error {
            XCTFail("Failed due to \(error.localizedDescription)")
        }
    }

    func testDecodingFromNonExistentFile() throws {
        // When
        do {
            let _: TestUser = try fileReader.decodeJSON(from: "MockUser")
            XCTFail("It shouldn't have found any file")
        } catch let error {
            XCTAssertEqual(error as? DecodeException, .notFound)
        }
    }
}
