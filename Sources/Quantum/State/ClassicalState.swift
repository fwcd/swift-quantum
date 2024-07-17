//
//  ClassicalState.swift
//  Quantum
//
//  Created on 13.06.24
//

import Foundation

/// A classical state, i.e. an array of bits.
public struct ClassicalState: Hashable, Codable, RawRepresentable, CustomStringConvertible {
    public private(set) var rawValue: [Bool]
    
    /// Creates a classical state from the given bits.
    public init(rawValue: [Bool] = []) {
        self.rawValue = rawValue
    }
    
    /// Creates a classical state from the given bits.
    public init(_ rawValue: [Bool]) {
        self.init(rawValue: rawValue)
    }
    
    /// The number of bits in the register.
    public var count: Int {
        rawValue.count
    }
    
    /// The integer representation of the register.
    public var value: Int {
        rawValue.reduce(0) { ($0 << 1) | ($1 ? 1 : 0) }
    }

    public var description: String {
        String(describing: rawValue)
    }
    
    /// Creates a classical state from the given value with the given number of bits.
    public init(value: Int, count: Int) {
        precondition(value < (1 << count), "\(value) is not representable with \(count) \("bit".pluralized(count))")
        
        var rawValue = Array(repeating: false, count: count)
        
        for i in 0..<count {
            rawValue[i] = ((value >> (count - 1 - i)) & 1) != 0
        }
        
        self.init(rawValue: rawValue)
    }
    
    /// Creates the zero state with the given number of counts.
    public static func zero(count: Int) -> Self {
        Self(value: 0, count: count)
    }
    
    public subscript(i: Int) -> Bool {
        get {
            i >= 0 && i < count ? rawValue[i] : false
        }
        set {
            if i >= 0 && i < count {
                rawValue[i] = newValue
            }
        }
    }
    
    /// Removes and returns the last bit.
    @discardableResult
    public mutating func popLast() -> Bool? {
        rawValue.popLast()
    }
    
    /// Appends the given bit.
    public mutating func append(_ bit: Bool) {
        rawValue.append(bit)
    }
    
    /// Fills the register with the given value.
    public mutating func fill(_ bit: (Int) -> Bool) {
        for i in 0..<count {
            self[i] = bit(i)
        }
    }
    
    /// Fills the register with the given constant bit.
    public mutating func fill(_ bit: Bool) {
        fill { _ in bit }
    }
    
    /// Fills the register with random bits.
    public mutating func randomize() {
        fill { _ in .random() }
    }
}

extension ClassicalState: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Bool...) {
        self.init(elements)
    }
}

extension ClassicalState: Sequence {
    public func makeIterator() -> [Bool].Iterator {
        rawValue.makeIterator()
    }
}
