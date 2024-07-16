//
//  QuantumRegisterTests.swift
//  Quantum
//
//  Created on 24.06.24
//

import XCTest
import Quantum

final class QuantumRegisterTests: XCTestCase {
    func testMeasurement() {
        XCTAssertEqual(QuantumRegister(value: 0b101, qubitCount: 3).measure(), [true, false, true])
        XCTAssertEqual(QuantumRegister(value: 0b101, qubitCount: 4).measure(), [false, true, false, true])
    }
}
