//
//  MVVMTestCases.swift
//  
//
//  Created by Mauricio Chirino on 11/4/21.
//

import XCTest
@testable import MauriUtils

protocol StorableValue {
    var data: String { get set }
}

struct DummyStore: StorableValue {
    var data: String
}

final class StorableSpy: StorableValue {
    var data: String

    init(data: String) {
        self.data = data
    }
}

final class FakeClass: DataSource<StorableValue> {
    private let storedData: StorableValue

    init(storedData: StorableValue) {
        self.storedData = storedData

        super.init()
    }

    func render(completion: @escaping (() -> Void)) {
        data.update { _ in
            completion()
        }
    }
}

final class MVVMTestCases: XCTestCase {
    var sut: FakeClass!
    var storableSpy: StorableSpy!
    let dataToBeModified = "lorem ipsum"

    func testDataUpdateIsNotifying() {
        // Given
        let dynamicTestExpectation = expectation(description: "")
        storableSpy = StorableSpy(data: dataToBeModified)
        sut = FakeClass(storedData: DummyStore(data: ""))

        // When
        sut.data.value = [storableSpy]

        // Then
        sut.render {
            self.thenAssertNotificationWasTriggered()
            dynamicTestExpectation.fulfill()
        }
        wait(for: [dynamicTestExpectation], timeout: 1)
    }

    func thenAssertNotificationWasTriggered() {
        XCTAssertEqual(sut.data.value.first?.data, dataToBeModified)
    }
}
