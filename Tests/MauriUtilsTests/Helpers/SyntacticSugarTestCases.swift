//
//  SyntacticSugarTestCases.swift
//  
//
//  Created by Mauricio Chirino on 04/01/21.
//

import XCTest
@testable import MauriUtils

final class SyntacticSugarTestCases: XCTestCase {
    var expectationForUI: XCTestExpectation!
    var dummyLabel: UILabel!

    override func setUp() {
        super.setUp()
        expectationForUI = expectation(description: "Update UI safely")
    }

    override func tearDown() {
        super.tearDown()
        expectationForUI = nil
        dummyLabel = nil
    }

    func testSafelyBackgroundThreadUpdate() {
        givenInitialSetupForUI()
        whenUpdateIsExecutedInBackgroundThread()
        thenVerifyUIWasUpdatedProperly()
    }

    func testDirectMainThreadRun() {
        givenInitialSetupForUI()
        whenOperationIsExecutedInTheMainThread()
        thenVerifyUIWasUpdatedProperly()
    }
}

private extension SyntacticSugarTestCases {
    func givenInitialSetupForUI() {
        dummyLabel = UILabel()
    }

    func whenUpdateIsExecutedInBackgroundThread() {
        DispatchQueue.global(qos: .background).async { [unowned self] in
            whenOperationIsExecutedInTheMainThread()
        }
    }

    func whenOperationIsExecutedInTheMainThread() {
        performUIUpdate { [unowned self] in
            dummyLabel.text = "lorem ipsum"
            expectationForUI.fulfill()
        }
    }

    func thenVerifyUIWasUpdatedProperly() {
        waitForExpectations(timeout: 0.01) { [unowned self] _ in
            XCTAssertEqual(dummyLabel.text, "lorem ipsum")
        }
    }
}
