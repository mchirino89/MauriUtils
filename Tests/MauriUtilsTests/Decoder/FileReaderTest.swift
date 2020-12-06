//
//  FileReaderTest.swift
//  MauriUtilsTests
//
//  Created by Mauricio Chirino on 18/04/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import XCTest
@testable import MauriUtils

final class FileReaderTest: XCTestCase {
    let fileName = "Temporal.json"
    let folderPath = NSTemporaryDirectory()
    var fileReader: FileReader!

    override func setUp() {
        super.setUp()
        fileReader = FileReader()
        createTestingFile()
    }

    override func tearDown() {
        super.tearDown()
        fileReader = nil
        try? FileManager.default.removeItem(atPath: folderPath)
    }

    private func createTestingFile() {
        try? FileManager.default.createDirectory(atPath: folderPath,
                                                 withIntermediateDirectories: true,
                                                 attributes: nil)
        let filePath = folderPath.appending(fileName)
        let json = try! JSONEncoder().encode(TestUserMock())
        try! json.write(to: URL(fileURLWithPath: filePath))
    }

    func testJSONReadingFromBundle() {
        let localFile = fileReader.read(in: Bundle.module, from: "validJSON")
        XCTAssertNotNil(localFile)
    }

    func testNonExistingFileFromBundle() {
        let localFile = fileReader.read(in: Bundle.module, from: "loremIpsum", and: .plist)
        XCTAssertNil(localFile)
    }

    func testReadLocalFile() {
        let path = folderPath + fileName
        XCTAssertNotNil(fileReader.readAt(url: path))
    }

    func testFailingReadingOfLocalFile() {
        XCTAssertNil(fileReader.readAt(url: ""), "Returning nil if file isn't found")
    }

}
