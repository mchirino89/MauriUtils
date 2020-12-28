//
//  DecoderExtensionTestCases.swift
//  
//
//  Created by Mauricio Chirino on 28/12/20.
//

import XCTest
@testable import MauriUtils

final class DecoderExtensionTestCases: XCTestCase {
    func testJSONDecodingFromNonExistentFile() {
        do {
            let _: TestUserMock = try TestUserMock.JSONFromFile(named: "MockUser", in: Bundle.module)
            XCTFail("It shouldn't have found any file")
        } catch let error {
            XCTAssertEqual(error as? DecodeException, .notFound)
        }
    }

    func testJSONDecodingFromAFileInBundle() throws {
        // When
        let decodedFile: TestUserMock = try XCTUnwrap(TestUserMock.JSONFromFile(named: "validJSON", in: Bundle.module))

        // Then
        XCTAssertEqual(decodedFile.name, "Mauricio Chirino")
    }
}
