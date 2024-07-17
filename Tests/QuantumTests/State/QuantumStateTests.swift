//
//  QuantumStateTests.swift
//  Quantum
//
//  Created on 24.06.24
//

import XCTest
import Quantum

final class QuantumStateTests: XCTestCase {
    func testMeasurement() {
        XCTAssertEqual(QuantumState(value: 0b101, qubitCount: 3).measure(), [true, false, true])
        XCTAssertEqual(QuantumState(value: 0b101, qubitCount: 4).measure(), [false, true, false, true])
    }
}
