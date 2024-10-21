//
//  Vector.swift
//  Quantum
//
//  Created on 13.06.24
//

import Foundation

/// A vector of complex numbers.
public struct Vector: Hashable, Codable, Sendable, RawRepresentable {
    public private(set) var rawValue: [Complex]
    
    /// The number of elements in the vector, i.e. the dimension.
    public var count: Int {
        rawValue.count
    }
    
    /// The squared length of the vector.
    public var magnitudeSquared: Double {
        rawValue.map(\.magnitudeSquared).reduce(0, +)
    }
    
    /// The length of the vector.
    public var magnitude: Double {
        sqrt(magnitudeSquared)
    }
    
    /// Whether the vector is (approximately) normalized.
    public var isNormalized: Bool {
        (magnitudeSquared - 1).isNegligible
    }
    
    public init(rawValue: [Complex] = []) {
        self.rawValue = rawValue
    }
    
    public init(_ rawValue: [Complex]) {
        self.init(rawValue: rawValue)
    }
    
    public init(repeating value: Complex, count: Int) {
        self.init(rawValue: Array(repeating: value, count: count))
    }
    
    public static func zero(count: Int) -> Self {
        Self(Array(repeating: 0, count: count))
    }
    
    public subscript(i: Int) -> Complex {
        get { rawValue[i] }
        set { rawValue[i] = newValue }
    }
    
    public static func *(lhs: Matrix, rhs: Self) -> Self {
        precondition(lhs.width == rhs.count)
        return Self(
            (0..<lhs.height).map { i in
                (0..<lhs.width).map { k in
                    lhs[i, k] * rhs[k]
                }.reduce(0, +)
            }
        )
    }
    
    /// The Kronecker (tensor) product with the given vector.
    public func kron(_ other: Self) -> Self {
        var product = Self.zero(count: count * other.count)
        for i1 in 0..<count {
            for i2 in 0..<other.count {
                product[i1 * other.count + i2] = self[i1] * other[i2]
            }
        }
        return product
    }
}

extension Vector: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Complex...) {
        self.init(elements)
    }
}

extension Vector: Sequence {
    public func makeIterator() -> [Complex].Iterator {
        rawValue.makeIterator()
    }
}

extension Matrix {
    /// Initializes the matrix with the given row vectors.
    public init(rows: [Vector]) {
        self.init(rawValue: rows.map(\.rawValue))
    }

    /// Initializes the matrix with the given column vectors.
    public init(columns: [Vector]) {
        self = Self(rows: columns).transpose
    }
}
