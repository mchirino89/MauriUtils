//
//  TestUserMock.swift
//  MauriUtilsTests
//
//  Created by Mauricio Chirino on 19/04/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import Foundation

struct TestUserMock: Codable {
    let name: String
    let age: Int
    let birthday: Int

    init() {
        name = "Mauricio Chirino"
        age = 29
        birthday = 620319600
    }
}

extension TestUserMock {
    static func ==(lhs: TestUserMock, rhs: TestUserMock) -> Bool {
        return lhs.name == rhs.name && lhs.age == rhs.age && lhs.birthday == rhs.birthday
    }
}
