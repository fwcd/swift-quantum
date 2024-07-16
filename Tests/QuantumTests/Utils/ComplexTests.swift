//
//  ComplexTests.swift
//  Quantum
//
//  Created on 12.06.24
//

import XCTest
import Quantum

final class ComplexTests: XCTestCase {
    func testArithmetic() {
        assert(Complex(real: 1), equals: 1)
        assert(.i * .i, equals: -1)
        assert(.i + 2, equals: Complex(real: 2, imag: 1))
        assert(Complex(8) * 9, equals: Complex(8 * 9))
        assert(Complex(1) / 3, equals: Complex(1 / 3))
        assert(Complex(3) / 4, equals: Complex(3 / 4))
        assert(-1 / .i, equals: .i)
        assert(.i / .i, equals: 1)
        assert((4 + 5 * .i) / (4 + 5 * .i), equals: 1)
    }
}
