//
//  XCTest+MemoryLeakTracker.swift
//  
//
//  Created by Mauricio Chirino on 24/4/21.
//

import XCTest

public extension XCTestCase {
    /// Checks whether inspected object persists in memory after parent class has been deallocated. [source](https://levelup.gitconnected.com/detecting-memory-leaks-using-unit-tests-in-swift-c37533e8ee4a)
    /// - Parameters:
    ///   - instance: class object to be inspected
    ///   - file: file where the offense is taking place. Defaults to current file
    ///   - line: specific line where the offense is taking place. Defaults to current line
    func trackForMemoryLeaks(on instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance,
                         "\(String(describing: instance)) should have been deallocated. Potential memory leak!",
                         file: file,
                         line: line)
        }
    }
}
