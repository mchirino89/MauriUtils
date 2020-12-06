//
//  FileInBundleDecoderTestCases.swift
//  
//
//  Created by Mauricio Chirino on 05/12/20.
//

import XCTest
@testable import MauriUtils

final class FileInBundleDecoderTestCases: XCTestCase {
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

    func testJSONDecodingFromAFileInBundle() throws {
        // When
        let decodedFile: TestUserMock = try XCTUnwrap(fileReader.decodeJSON(in: Bundle.module, from: "validJSON"))

        // Then
        XCTAssertEqual(decodedFile.name, "Mauricio Chirino")
    }

    func testCorruptedJSONDecodingFromAFileInBundle() {
        // When
        do {
            let _: TestUserMock = try fileReader.decodeJSON(in: Bundle.module, from: "corruptJSON")
            XCTFail("Corrupted JSON should throw an exception")
        } catch let error {
            XCTAssertEqual(error as? DecodeException, .unparseable)
        }
    }

    func testJSONDecodingFromNonExistentFile() throws {
        // When
        do {
            let _: TestUserMock = try fileReader.decodeJSON(from: "MockUser")
            XCTFail("It shouldn't have found any file")
        } catch let error {
            XCTAssertEqual(error as? DecodeException, .notFound)
        }
    }

    func testPlistDecodingFromNonExistentFile() throws {
        // When
        do {
            let _: TestUserMock = try fileReader.decodePlist(from: "MockUser")
            XCTFail("It shouldn't have found any file")
        } catch let error {
            XCTAssertEqual(error as? DecodeException, .notFound)
        }
    }

    func testPlistDecodingFromAFileInBundle() throws {
        // When
        let decodedFile: FrameworkSetupMock = try XCTUnwrap(fileReader.decodePlist(in: Bundle.module,
                                                                                   from: "TrackingFrameworkSetup"))
        // Then
        XCTAssertEqual(decodedFile.key, "loremIpsumDoriem")
    }

    func testPlistDecodingErrorHandlingForTypeMismatch() throws {
        // When
        do {
            let _: TestUserMock = try fileReader.decodePlist(in: Bundle.module, from: "TrackingFrameworkSetup")
            XCTFail("It shouldn't have parsed the file into a wrong type")
        } catch let producedError {
            // Then
            XCTAssertEqual(producedError as? DecodeException, .unparseable)
        }
    }
}
