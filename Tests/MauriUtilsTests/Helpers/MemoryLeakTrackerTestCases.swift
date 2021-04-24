//
//  MemoryLeakTrackerTestCases.swift
//  
//
//  Created by Mauricio Chirino on 24/4/21.
//

@testable import MauriUtils
import XCTest

class ParentClass {
    var childs: [ChildClass] = []
}

class ChildClass {
    weak var parentReference: ParentClass?
}

final class MemoryLeakTrackerTestCases: XCTestCase {
    func testProperTrackingForMemoryLeaks() {
        // Given
        let fakeParent: ParentClass? = ParentClass()
        let dummyChildA: ChildClass? = ChildClass()
        let dummyChildB: ChildClass? = ChildClass()

        // When
        fakeParent!.childs.append(dummyChildA!)
        fakeParent!.childs.append(dummyChildB!)
        dummyChildA!.parentReference = fakeParent
        dummyChildB!.parentReference = fakeParent

        // Verify
        trackForMemoryLeaks(on: fakeParent!)
        trackForMemoryLeaks(on: dummyChildA!)
        trackForMemoryLeaks(on: dummyChildB!)
    }
}
