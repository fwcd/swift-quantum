//
//  Matrix+Gates.swift
//  Quantum
//
//  Created on 24.06.24
//

extension Matrix {
    /// The 2x2 Hadamard gate.
    public static let hadamard: Self = Complex(1 / 2.squareRoot()) * Self([
        [1,  1],
        [1, -1],
    ])
    
    /// The Pauli X gate (bit flip).
    public static let x: Self = [
        [0, 1],
        [1, 0],
    ]
    
    /// The Pauli Y gate.
    public static let y: Self = [
        [0, -.i],
        [.i, 0],
    ]
    
    /// The Pauli Z gate (phase flip).
    public static let z: Self = [
        [1, 0],
        [0, -1],
    ]
}
