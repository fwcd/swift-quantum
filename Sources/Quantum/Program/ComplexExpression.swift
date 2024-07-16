//
//  ComplexExpression.swift
//  Quantum
//
//  Created on 24.06.24
//

import Foundation

/// An expression representing a complex number.
public indirect enum ComplexExpression: Hashable, Codable {
    case int(Int)
    case complex(Complex)
    case squareRoot(ComplexExpression)
    case product(ComplexExpression, ComplexExpression)
    case quotient(ComplexExpression, ComplexExpression)
    
    /// The imaginary constant i.
    public static var i: Self {
        .complex(.i)
    }
    
    /// The precedence of the operation.
    private var precedence: Int {
        switch self {
        case .int, .complex, .squareRoot, .quotient: 100
        case .product: 50
        }
    }
    
    /// The corresponding LaTeX math expression.
    public var latex: String {
        switch self {
        case let .int(value): "\(value)"
        case let .complex(value): "\(value)"
        case let .squareRoot(operand): "\\sqrt{\(operand.latex)}"
        case let .product(lhs, rhs): "\(parenthesizedLatex(lhs)) \(parenthesizedLatex(rhs))"
        case let .quotient(lhs, rhs): "\\frac{\(lhs.latex)}{\(rhs.latex)}"
        }
    }
    
    private func parenthesizedLatex(_ operand: Self) -> String {
        // TODO: We assume associativity here by not handling equal precedence
        operand.precedence < precedence ? "(\(operand.latex))" : operand.latex
    }
}

extension Complex {
    /// Evaluates the expression.
    public init(_ expr: ComplexExpression) {
        switch expr {
        case let .int(value): self.init(Double(value))
        case let .complex(value): self = value
        case let .squareRoot(operand): self = Complex(operand).squareRoot
        case let .product(lhs, rhs): self = Complex(lhs) * Complex(rhs)
        case let .quotient(lhs, rhs): self = Complex(lhs) / Complex(rhs)
        }
    }
}

extension ComplexExpression: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .int(value)
    }
}

extension ComplexExpression: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .complex(.init(value))
    }
}
