//
//  Matrix.swift
//  Quantum
//
//  Created on 12.06.24
//

/// A matrix of complex numbers.
public struct Matrix: Hashable, Codable, Sendable, RawRepresentable {
    public private(set) var rawValue: [[Complex]] {
        didSet {
            checkInvariants()
        }
    }
    
    /// The number of rows in the matrix.
    public var height: Int {
        rawValue.count
    }
    
    /// The number of columns in the matrix.
    public var width: Int {
        rawValue[0].count
    }

    /// The transpose of the matrix.
    public var transpose: Self {
        Self((0..<width).map { i in rawValue.map { $0[i] } })
    }
    
    public init(rawValue: [[Complex]] = []) {
        self.rawValue = rawValue
        checkInvariants()
    }
    
    public init(_ rawValue: [[Complex]]) {
        self.init(rawValue: rawValue)
    }
    
    public static func zero(_ height: Int, _ width: Int) -> Self {
        Self(Array(repeating: Array(repeating: 0, count: width), count: height))
    }
    
    public static func identity(_ size: Int) -> Self {
        var matrix = Self.zero(size, size)
        for k in 0..<size {
            matrix[k, k] = 1
        }
        return matrix
    }
    
    private func checkInvariants() {
        precondition(!rawValue.isEmpty, "Matrix must not be empty")
        precondition(rawValue.allSatisfy { $0.count == rawValue[0].count }, "Ragged matrices are not supported")
    }
    
    public subscript(_ i: Int, _ j: Int) -> Complex {
        get { rawValue[i][j] }
        set { rawValue[i][j] = newValue }
    }
    
    public func map(_ transform: (Complex) throws -> Complex) rethrows -> Self {
        Self(try rawValue.map { try $0.map(transform) })
    }
    
    public func zip(_ other: Matrix, with operation: (Complex, Complex) throws -> Complex) rethrows -> Self {
        precondition(width == other.width && height == other.height)
        return Self(
            try Swift.zip(rawValue, other.rawValue).map {
                try Swift.zip($0.0, $0.1).map {
                    try operation($0.0, $0.1)
                }
            }
        )
    }
    
    /// The Kronecker (tensor) product with the given matrix.
    public func kron(_ other: Self) -> Self {
        var product = Self.zero(height * other.height, width * other.width)
        for i1 in 0..<height {
            for j1 in 0..<width {
                for i2 in 0..<other.height {
                    for j2 in 0..<other.width {
                        product[i1 * other.height + i2, j1 * other.width + j2] = self[i1, j1] * other[i2, j2]
                    }
                }
            }
        }
        return product
    }
    
    /// Kronecker exponentiation.
    public func kronPow(_ n: Int) -> Self {
        precondition(n >= 1)
        guard n != 1 else {
            return self
        }
        var result = self
        for _ in 1..<n {
            result = result.kron(self)
        }
        return result
    }
    
    public static func +(lhs: Self, rhs: Self) -> Self {
        lhs.zip(rhs, with: +)
    }
    
    public static func -(lhs: Self, rhs: Self) -> Self {
        lhs.zip(rhs, with: -)
    }
    
    public static func *(lhs: Self, rhs: Complex) -> Self {
        lhs.map { $0 * rhs }
    }
    
    public static func *(lhs: Complex, rhs: Self) -> Self {
        rhs.map { lhs * $0 }
    }
    
    public static func *(lhs: Self, rhs: Self) -> Self {
        precondition(lhs.width == rhs.height)
        return Self(
            (0..<lhs.height).map { i in
                (0..<rhs.width).map { j in
                    (0..<lhs.width).map { k in
                        lhs[i, k] * rhs[k, j]
                    }.reduce(0, +)
                }
            }
        )
    }
    
    public static func /(lhs: Self, rhs: Complex) -> Self {
        lhs.map { $0 / rhs }
    }
    
    public static prefix func -(operand: Self) -> Self {
        operand.map(-)
    }
    
    public mutating func negate() {
        self = -self
    }
}

extension Matrix: Sequence {
    public func makeIterator() -> some IteratorProtocol<[Complex]> {
        rawValue.makeIterator()
    }
}

extension Matrix: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: [Complex]...) {
        self.init(rawValue: elements)
    }
}
