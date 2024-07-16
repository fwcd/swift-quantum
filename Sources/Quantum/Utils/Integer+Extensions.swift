//
//  Integer+Extensions.swift
//  Quantum
//
//  Created on 24.06.24
//

extension BinaryInteger {
    /// Whether this integer is a (positive) power of two.
    var isPowerOfTwo: Bool {
        self > 0 && (self & (self - 1)) == 0
    }
}
