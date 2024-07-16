//
//  FloatingPoint+Extensions.swift
//  Quantum
//
//  Created on 24.06.24
//

private let epsilon = 0.00001

extension Double {
    /// Whether the number is very close to zero.
    public var isNegligible: Bool {
        abs(self) < epsilon
    }
    
    /// The sign of the number.
    public var signum: Double {
        self > 0 ? 1 : (self < 0 ? -1 : 0)
    }
}
