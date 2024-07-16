//
//  QuantumTransformationExpression.swift
//  Quantum
//
//  Created on 24.06.24
//

import Foundation

/// An expression representing a quantum state transformation.
public indirect enum QuantumTransformationExpression: Hashable, Codable {
    case identity
    case hadamard
    case x
    case y
    case z
    case scale(ComplexExpression, QuantumTransformationExpression)
    case kron(QuantumTransformationExpression, QuantumTransformationExpression)
    case kronPow(QuantumTransformationExpression, Int)
    case oracle(QuantumOracle)
    case matrix(Matrix)
    
    /// Aggregates Kronecker factors.
    private var kronFactors: [(base: Self, exponent: Int)] {
        switch self {
        case let .kron(lhs, rhs):
            let lhsFactors = lhs.kronFactors
            let rhsFactors = rhs.kronFactors
            // Merge adjacent factors
            if let lastLeft = lhsFactors.last,
               let firstRight = rhsFactors.first,
               lastLeft.base == firstRight.base {
                return lhsFactors.dropLast() + [(base: lastLeft.base, exponent: lastLeft.exponent + firstRight.exponent)] + rhsFactors.dropFirst()
            } else {
                return lhsFactors + rhsFactors
            }
        case let .kronPow(operand, n):
            return operand.kronFactors.map { (base: $0.base, exponent: $0.exponent * n) }
        default:
            return [(base: self, exponent: 1)]
        }
    }
    
    /// A simplified version of the expression.
    public var simplified: Self {
        switch self {
        case .kron, .kronPow:
            kronFactors
                .map { $0.exponent == 1 ? $0.base : .kronPow($0.base, $0.exponent) }
                .reduce1 { .kron($0, $1) }!
        case let .scale(factor, operand):
            .scale(factor, operand.simplified)
        default:
            self
        }
    }

    /// The precedence of the operation.
    private var precedence: Int {
        switch self {
        case .identity, .hadamard, .x, .y, .z, .kronPow, .oracle, .matrix: 100
        case .scale: 50
        case .kron: 10
        }
    }
    
    /// The corresponding LaTeX math expression.
    public var latex: String {
        switch self {
        case .identity: "I"
        case .hadamard: "H"
        case .x: "X"
        case .y: "Y"
        case .z: "Z"
        case let .scale(factor, operand): "\(factor.latex) \(parenthesizedLatex(operand))"
        case let .kron(lhs, rhs): "\(parenthesizedLatex(lhs)) \\otimes \(parenthesizedLatex(rhs))"
        case let .kronPow(lhs, rhs): "{\(parenthesizedLatex(lhs))}^{\\otimes \(rhs)}"
        case let .oracle(oracle): oracle.latex
        case let .matrix(matrix): "\\begin{pmatrix}\(matrix.map { $0.map { "\($0)" }.joined(separator: " & ") }.joined(separator: " \\\\ "))\\end{pmatrix}"
        }
    }
    
    /// The number of qubits that this expression operates on.
    public var qubitCount: Int {
        Matrix(self).width.trailingZeroBitCount
    }
    
    private func parenthesizedLatex(_ operand: Self) -> String {
        // TODO: We assume associativity here by not handling equal precedence
        operand.precedence < precedence ? "(\(operand.latex))" : operand.latex
    }
}

extension Matrix {
    /// Evaluates the quantum transformation expression.
    public init(_ expr: QuantumTransformationExpression) {
        switch expr {
        case .identity: self = .identity(2)
        case .hadamard: self = .hadamard
        case .x: self = .x
        case .y: self = .y
        case .z: self = .z
        case let .scale(factor, operand): self = Complex(factor) * Matrix(operand)
        case let .kron(lhs, rhs): self = Matrix(lhs).kron(Matrix(rhs))
        case let .kronPow(lhs, rhs): self = Matrix(lhs).kronPow(rhs)
        case let .oracle(oracle): self = Matrix(oracle)
        case let .matrix(matrix): self = matrix
        }
    }
}
