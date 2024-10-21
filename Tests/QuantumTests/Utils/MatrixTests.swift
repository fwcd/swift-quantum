//
//  MatrixTests.swift
//  Quantum
//
//  Created on 13.06.24
//

import Testing
import Quantum

struct MatrixTests {
    @Test func zero() {
        expect(.zero(3, 3), equals: [
            [0, 0, 0],
            [0, 0, 0],
            [0, 0, 0],
        ])
        expect(.zero(2, 4), equals: [
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ])
    }

    @Test func transpose() {
        expect(Matrix([
            [1, 2, 3],
            [4, 5, 6],
        ]).transpose, equals: [
            [1, 4],
            [2, 5],
            [3, 6],
        ])
    }
    
    @Test func identity() {
        expect(.identity(1), equals: [
            [1],
        ])
        expect(.identity(3), equals: [
            [1, 0, 0],
            [0, 1, 0],
            [0, 0, 1],
        ])
    }
    
    @Test func arithmetic() {
        expect(Matrix([
            [1, 2],
            [3, 4],
        ]) + Matrix([
            [3, 2],
            [5, 4],
        ]), equals: [
            [4, 4],
            [8, 8],
        ])
        
        expect(Matrix([
            [1, 2],
            [3, 4],
        ]) - Matrix([
            [3, 2],
            [5, 4],
        ]), equals: [
            [-2, 0],
            [-2, 0],
        ])
        
        expect(Matrix([
            [-1, 2],
            [-4, -3],
        ]) * Complex.i, equals: [
            [-1 * .i, 2 * .i],
            [-4 * .i, -3 * .i],
        ])
        
        expect(Complex.i * Matrix([
            [-1, 2],
            [-4, -3],
        ]), equals: [
            [-1 * .i, 2 * .i],
            [-4 * .i, -3 * .i],
        ])
    }
    
    @Test func matrixMultiplication() {
        expect(Matrix([
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
    
    @Test func kroneckerProduct() {
        expect(Matrix([
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
    
    @Test func kroneckerExponentiation() {
        let a: Matrix = [
            [1, 2],
            [3, 4]
        ]
        expect(a.kronPow(1), equals: a)
        expect(a.kronPow(2), equals: a.kron(a))
        expect(a.kronPow(3), equals: a.kron(a).kron(a))
    }
}
