//
//  Complex.swift
//  Quantum
//
//  Created on 12.06.24
//

import Foundation

/// A complex number, internally represented with two doubles.
public struct Complex: Hashable, Codable {
    public var real: Double
    public var imag: Double
    
    public init(real: Double = 0, imag: Double = 0) {
        self.real = real
        self.imag = imag
    }
    
    public init(_ real: Double) {
        self.init(real: real)
    }
}

extension Complex {
    public static let i = Self(imag: 1)
    
    public var conjugate: Self {
        Self(real: real, imag: -imag)
    }
    
    public var magnitudeSquared: Double {
        real * real + imag * imag
    }
    
    public var magnitude: Double {
        hypot(real, imag)
    }
    
    /// Whether the number is very close to zero.
    public var isNegligible: Bool {
        real.isNegligible && imag.isNegligible
    }
    
    public var squareRoot: Self {
        // https://math.stackexchange.com/a/44414
        guard imag != 0 else {
            return Self(real.squareRoot())
        }
        let magnitude = magnitude
        return Complex(
            real: ((real + magnitude) / 2).squareRoot(),
            imag: imag.signum * ((magnitude - real) / 2).squareRoot()
        )
    }
}

extension Complex: CustomStringConvertible {
    public var description: String {
        if imag == 0 {
            return "\(real)"
        }
        if real == 0 {
            return "\(imag == 1 ? "" : "\(imag)")i"
        }
        return "\(real) + \(imag)i"
    }
}

extension Complex: AdditiveArithmetic {
    public static let zero = Self()
    
    public static func +(lhs: Self, rhs: Self) -> Self {
        Self(real: lhs.real + rhs.real, imag: lhs.imag + rhs.imag)
    }
    
    public static func -(lhs: Self, rhs: Self) -> Self {
        Self(real: lhs.real - rhs.real, imag: lhs.imag - rhs.imag)
    }
}

extension Complex: Numeric {
    public init?<T>(exactly source: T) where T: BinaryInteger {
        guard let real = Double(exactly: source) else { return nil }
        self.init(real)
    }
    
    public static func *(lhs: Self, rhs: Self) -> Self {
        //   (a + bi) (c + di)
        // = ac + adi + bci - bd
        // = ac - bd + (ad + bc)i
        Self(
            real: lhs.real * rhs.real - lhs.imag * rhs.imag,
            imag: lhs.real * rhs.imag + lhs.imag * rhs.real
        )
    }
    
    public static func /(lhs: Self, rhs: Self) -> Self {
        //   (a + bi) / (c + di)
        // = (a + bi) (c - di) / (c + di) (c - di)
        // = (ac - adi + bci + bd) / (c^2 + d^2)
        // = (ac + bd + (bc - ad)i) / (c^2 + d^2)
        let divisor = rhs.real * rhs.real + rhs.imag * rhs.imag
        return Self(
            real: (lhs.real * rhs.real + lhs.imag * rhs.imag) / divisor,
            imag: (lhs.imag * rhs.real - lhs.real * rhs.imag) / divisor
        )
    }
    
    public static func *=(lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs
    }
    
    public static func /=(lhs: inout Self, rhs: Self) {
        lhs = lhs / rhs
    }
}

extension Complex: SignedNumeric {
    public prefix static func -(operand: Self) -> Self {
        Self(real: -operand.real, imag: -operand.imag)
    }
    
    public mutating func negate() {
        real.negate()
        imag.negate()
    }
}

extension Complex: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(Double(value))
    }
}

extension Complex: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self.init(value)
    }
}
