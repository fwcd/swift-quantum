//
//  MatrixTests.swift
//  Quantum
//
//  Created on 13.06.24
//

import XCTest
import Quantum

final class MatrixTests: XCTestCase {
    func testZero() {
        assert(.zero(3, 3), equals: [
            [0, 0, 0],
            [0, 0, 0],
            [0, 0, 0],
        ])
        assert(.zero(2, 4), equals: [
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ])
    }
    
    func testIdentity() {
        assert(.identity(1), equals: [
            [1],
        ])
        assert(.identity(3), equals: [
            [1, 0, 0],
            [0, 1, 0],
            [0, 0, 1],
        ])
    }
    
    func testArithmetic() {
        assert(Matrix([
            [1, 2],
            [3, 4],
        ]) + Matrix([
            [3, 2],
            [5, 4],
        ]), equals: [
            [4, 4],
            [8, 8],
        ])
        
        assert(Matrix([
            [1, 2],
            [3, 4],
        ]) - Matrix([
            [3, 2],
            [5, 4],
        ]), equals: [
            [-2, 0],
            [-2, 0],
        ])
        
        assert(Matrix([
            [-1, 2],
            [-4, -3],
        ]) * Complex.i, equals: [
            [-1 * .i, 2 * .i],
            [-4 * .i, -3 * .i],
        ])
        
        assert(Complex.i * Matrix([
            [-1, 2],
            [-4, -3],
        ]), equals: [
            [-1 * .i, 2 * .i],
            [-4 * .i, -3 * .i],
        ])
    }
    
    func testMatrixMultiplication() {
        assert(Matrix([
            [1, 2, 3],
            [4, 5, 6],
        ]) * Matrix([
            [7, 8],
            [9, 10],
            [11, 12],
        ]), equals: [
            [58, 64],
            [139, 154],
        ])
    }
    
    func testKroneckerProduct() {
        assert(Matrix([
            [1, 2],
            [3, 4]
        ]).kron(Matrix([
            [5, 6,  7],
            [8, 9, 10]
        ])), equals: [
            [ 5,  6,  7, 10, 12, 14],
            [ 8,  9, 10, 16, 18, 20],
            [15, 18, 21, 20, 24, 28],
            [24, 27, 30, 32, 36, 40]
        ])
    }
    
    func testKroneckerExponentiation() {
        let a: Matrix = [
            [1, 2],
            [3, 4]
        ]
        assert(a.kronPow(1), equals: a)
        assert(a.kronPow(2), equals: a.kron(a))
        assert(a.kronPow(3), equals: a.kron(a).kron(a))
    }
}
