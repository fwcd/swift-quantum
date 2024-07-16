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
    public func states(for input: ClassicalRegister) throws -> [QuantumRegister] {
        try operations.scan(QuantumRegister(input)) { state, operation in
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
    public func finalState(for input: ClassicalRegister) throws -> QuantumRegister {
        try states(for: input).last!
    }
    
    /// A measurement of the state after running the quantum program on the given input.
    public func measuredState(for input: ClassicalRegister) throws -> ClassicalRegister {
        try finalState(for: input).measure()
    }

    /// Clears the program's operations.
    public mutating func clear() {
        operations = []
    }
}

extension QuantumProgram: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Identified<QuantumOperation>...) {
        self.init(operations: elements)
    }
}
