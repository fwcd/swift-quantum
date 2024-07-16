//
//  TestHelpers.swift
//  Quantum
//
//  Created on 13.06.24
//

import XCTest
import Quantum

private let epsilon = 0.00001

func assert(_ lhs: Complex, equals rhs: Complex, _ message: String? = nil, file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(lhs.real, rhs.real, accuracy: epsilon, message ?? "Re(\(lhs)) != Re(\(rhs))", file: file, line: line)
    XCTAssertEqual(lhs.imag, rhs.imag, accuracy: epsilon, message ?? "Im(\(lhs)) != Im(\(rhs))", file: file, line: line)
}

func assert(_ lhs: Matrix, equals rhs: Matrix, file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(lhs.width, rhs.width, "Left height != right height", file: file, line: line)
    XCTAssertEqual(lhs.height, rhs.height, "Left width != right width", file: file, line: line)
    for i in 0..<lhs.height {
        for j in 0..<lhs.width {
            assert(lhs[i, j], equals: rhs[i, j], "Element at \(i), \(j) does not match", line: line)
        }
    }
}

func assert(_ lhs: Vector, equals rhs: Vector, file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(lhs.count, rhs.count, "Left count != right count", file: file, line: line)
    for i in 0..<lhs.count {
        assert(lhs[i], equals: rhs[i], "Element at \(i) does not match", file: file, line: line)
    }
}
