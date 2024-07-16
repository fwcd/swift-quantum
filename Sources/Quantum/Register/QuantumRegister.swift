//
//  QuantumRegister.swift
//  Quantum
//
//  Created on 13.06.24
//

import Foundation

/// A quantum state, i.e. a complex probability distribution.
public struct QuantumRegister: Hashable, Codable, RawRepresentable {
    public private(set) var rawValue: Vector {
        didSet {
            checkInvariants()
        }
    }
    
    /// The dimension of the register, equivalent to `pow(2, qubitCount)`.
    public var dimension: Int {
        rawValue.count
    }
    
    /// The number of qubits in this register.
    public var qubitCount: Int {
        dimension.trailingZeroBitCount
    }
    
    /// Whether the state corresponds to a single classical state, i.e. whether the state is fully deterministic.
    public var isBasisState: Bool {
        rawValue.allSatisfy({ ($0 - 0).isNegligible || ($0 - 1).isNegligible })
    }
    
    /// Creates a quantum state from the given distribution.
    public init(rawValue: Vector = .init()) {
        self.rawValue = rawValue
        checkInvariants()
    }
    
    /// Creates a quantum state from the given distribution.
    public init(_ rawValue: Vector) {
        self.init(rawValue: rawValue)
    }
    
    /// Creates a quantum basis state from the given classical state.
    public init(_ register: ClassicalRegister) {
        var rawValue = Vector.zero(count: 1 << register.count)
        rawValue[register.value] = 1
        self.init(rawValue: rawValue)
    }
    
    /// Creates a quantum basis state from the given value and qubit count.
    public init(value: Int, qubitCount: Int) {
        self.init(ClassicalRegister(value: value, count: qubitCount))
    }
    
    /// Creates the zero basis state with the given number of qubits.
    public static func zero(qubitCount: Int) -> Self {
        Self(value: 0, qubitCount: qubitCount)
    }
    
    /// Creates the uniform state with the given number of qubits.
    public static func uniform(qubitCount: Int) -> Self {
        Self(Vector(repeating: Complex(real: 1 / pow(2, Double(qubitCount) / 2)), count: 1 << qubitCount))
    }
    
    private func checkInvariants() {
        precondition(rawValue.count.isPowerOfTwo, "Quantum state dimension \(rawValue.count) is not power of two")
        precondition(rawValue.isNormalized, "Quantum state \(rawValue) is not normalized")
    }
    
    /// Measures the quantum state (nondeterministically).
    public func measure() -> ClassicalRegister {
        var x = Double.random(in: 0..<1)
        for (i, amplitude) in rawValue.enumerated() {
            x -= amplitude.magnitudeSquared
            if x <= 0 {
                return ClassicalRegister(value: i, count: qubitCount)
            }
        }
        return ClassicalRegister(value: dimension - 1, count: qubitCount)
    }
    
    /// Applies the given quantum state transformation.
    public static func *(lhs: Matrix, rhs: Self) -> Self {
        Self(rawValue: lhs * rhs.rawValue)
    }
    
    /// Applies the given quantum state transformation.
    public static func *(lhs: QuantumTransformationExpression, rhs: Self) -> Self {
        Matrix(lhs) * rhs
    }
    
    /// Applies the given quantum operation.
    public static func *(lhs: QuantumOperation, rhs: Self) -> Self {
        switch lhs {
        case .transform(let transformation): transformation * rhs
        case .measure: Self(rhs.measure())
        }
    }
}

extension Matrix {
    /// Initializes the matrix with the given row states.
    init(rows: [QuantumRegister]) {
        precondition(!rows.isEmpty, "Cannot construct empty quantum transformation")
        precondition(rows.allSatisfy { $0.dimension == rows.count }, "Rows (i.e. mapped basis states) of quantum transformation are not of equal dimension: \(rows.map(\.dimension))")

        self.init(rows: rows.map(\.rawValue))
    }

    /// Initializes the matrix with the given column states.
    init(columns: [QuantumRegister]) {
        precondition(!columns.isEmpty, "Cannot construct empty quantum transformation")
        precondition(columns.allSatisfy { $0.dimension == columns.count }, "Columns (i.e. mapped basis states) of quantum transformation are not of equal dimension: \(columns.map(\.dimension))")

        self.init(columns: columns.map(\.rawValue))
    }
}
