//
//  ClassicalRegisterTests.swift
//  Quantum
//
//  Created on 24.06.24
//

import XCTest
import Quantum

final class ClassicalRegisterTests: XCTestCase {
    func testValue() {
        XCTAssertEqual(ClassicalRegister(value: 0, count: 1).rawValue, [false])
        XCTAssertEqual(ClassicalRegister(value: 0b01, count: 2).rawValue, [false, true])
        XCTAssertEqual(ClassicalRegister(value: 0b110, count: 4).rawValue, [false, true, true, false])
        
        XCTAssertEqual(ClassicalRegister(value: 0b1, count: 1).value, 1)
        XCTAssertEqual(ClassicalRegister(value: 0b110, count: 3).value, 6)
        XCTAssertEqual(ClassicalRegister(value: 0b111, count: 4).value, 7)
    }
}
