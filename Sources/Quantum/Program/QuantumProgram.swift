//
//  QuantumProgram.swift
//  Quantum
//
//  Created on 24.06.24
//

/// A list of quantum operations forming a quantum program.
public struct QuantumProgram: Hashable, Codable {
    public var operations: [Identified<QuantumOperation>]
    
    public init(operations: [Identified<QuantumOperation>] = []) {
        self.operations = operations
    }

    /// The initial, intermediate and final states while running the quantum
    /// program on the given input. This list is never empty.
    public func states(for input: ClassicalState) throws -> [QuantumState] {
        try operations.scan(QuantumState(input)) { state, operation in
            if case let .transform(transformation) = operation.wrappedValue,
                transformation.qubitCount != state.qubitCount {
                throw QuantumProgramError(
                    operationId: operation.id,
                    description: "Operation operates on \(transformation.qubitCount), not \(state.qubitCount) \("qubit".pluralized(state.qubitCount))"
                )
            }
            return operation.wrappedValue * state
        }
    }
    
    /// The state after running the quantum program on the given input.
    public func finalState(for input: ClassicalState) throws -> QuantumState {
        try states(for: input).last!
    }
    
    /// A measurement of the state after running the quantum program on the given input.
    public func measuredState(for input: ClassicalState) throws -> ClassicalState {
        try finalState(for: input).measure()
    }

    /// Concatenates the given two programs.
    public static func +(lhs: Self, rhs: Self) -> Self {
        Self(operations: lhs.operations + rhs.operations)
    }

    /// Appends the given program.
    public static func +=(lhs: inout Self, rhs: Self) {
        lhs.operations += rhs.operations
    }

    /// Clears the program's operations.
    public mutating func clear() {
        operations = []
    }
}

extension QuantumProgram: Sequence {
    public func makeIterator() -> [Identified<QuantumOperation>].Iterator {
        operations.makeIterator()
    }
}

extension QuantumProgram: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Identified<QuantumOperation>...) {
        self.init(operations: elements)
    }
}
