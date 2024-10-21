//
//  ComplexTests.swift
//  Quantum
//
//  Created on 12.06.24
//

import Testing
import Quantum

struct ComplexTests {
    @Test func arithmetic() {
        expect(Complex(real: 1), equals: 1)
        expect(.i * .i, equals: -1)
        expect(.i + 2, equals: Complex(real: 2, imag: 1))
        expect(Complex(8) * 9, equals: Complex(8 * 9))
        expect(Complex(1) / 3, equals: Complex(1 / 3))
        expect(Complex(3) / 4, equals: Complex(3 / 4))
        expect(-1 / .i, equals: .i)
        expect(.i / .i, equals: 1)
        expect((4 + 5 * .i) / (4 + 5 * .i), equals: 1)
    }
}
