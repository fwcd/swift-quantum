//
//  VectorTests.swift
//  Quantum
//
//  Created on 24.06.24
//

import Foundation
import Testing
import Quantum

struct VectorTests {
    @Test func zero() {
        expect(.zero(count: 3), equals: [0, 0, 0])
        expect(.zero(count: 4), equals: [0, 0, 0, 0])
    }
    
    @Test func matrixMultiplication() {
        expect(Matrix([
            [1, 2, 3],
            [4, 5, 6],
        ]) * Vector([
            7,
            9,
            11,
        ]), equals: [
            58,
            139,
        ])
    }
    
    @Test func kroneckerProduct() {
        expect(Vector([1, 2]).kron(Vector([3, 4])), equals: [3, 4, 6, 8])
    }
}
