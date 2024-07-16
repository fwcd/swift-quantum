//
//  VectorTests.swift
//  Quantum
//
//  Created on 24.06.24
//

import Foundation

import XCTest
import Quantum

final class VectorTests: XCTestCase {
    func testZero() {
        assert(.zero(count: 3), equals: [0, 0, 0])
        assert(.zero(count: 4), equals: [0, 0, 0, 0])
    }
    
    func testMatrixMultiplication() {
        assert(Matrix([
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
    
    func testKroneckerProduct() {
        assert(Vector([1, 2]).kron(Vector([3, 4])), equals: [3, 4, 6, 8])
    }
}
