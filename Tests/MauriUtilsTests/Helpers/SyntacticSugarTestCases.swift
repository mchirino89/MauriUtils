//
//  SyntacticSugarTestCases.swift
//  
//
//  Created by Mauricio Chirino on 04/01/21.
//

import XCTest
@testable import MauriUtils

final class SyntacticSugarTestCases: XCTestCase {
    var expectation: XCTestExpectation!
    var dummyArray: [Int]!

    override func setUp() {
        super.setUp()
        expectation = expectation(description: "Update on main thread safely")
    }

    override func tearDown() {
        super.tearDown()
        expectation = nil
        dummyArray.removeAll()
    }

    func testSafelyBackgroundThreadUpdate() {
        givenInitialSetup()
        whenUpdateIsExecutedInBackgroundThread()
        thenVerifyProperUpdate()
    }

    func testDirectMainThreadRun() {
        givenInitialSetup()
        whenOperationIsExecutedInTheMainThread()
        thenVerifyProperUpdate()
    }
}

private extension SyntacticSugarTestCases {
    func givenInitialSetup() {
        dummyArray = []
    }

    func whenUpdateIsExecutedInBackgroundThread() {
        DispatchQueue.global(qos: .background).async { [unowned self] in
            whenOperationIsExecutedInTheMainThread()
        }
    }

    func whenOperationIsExecutedInTheMainThread() {
        executeMainThreadUpdate { [unowned self] in
            dummyArray.append(contentsOf: [1, 2, 3])
            expectation.fulfill()
        }
    }

    func thenVerifyProperUpdate() {
        waitForExpectations(timeout: 1) { [unowned self] _ in
            XCTAssertEqual(dummyArray.count, 3)
        }
    }
}
