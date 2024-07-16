//
//  QuantumProgram.swift
//  Quantum
//
//  Created on 24.06.24
//

/// A quantum program.
public struct QuantumProgram: Hashable, Codable {
    public var initialState: ClassicalRegister
    public var operations: [Identified<QuantumOperation>]
    
    /// The intermediate and final states while running the quantum program.
    public var states: [QuantumRegister] {
        get throws {
            try operations.scan(QuantumRegister(initialState)) { state, operation in
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
    }
    
    /// The state after running the quantum program.
    public var finalState: QuantumRegister {
        get throws {
            try states.last!
        }
    }
    
    /// The final classical state. Requires the last operation to be a measurement.
    public var measuredState: ClassicalRegister {
        get throws {
            try finalState.measure()
        }
    }

    public init(
        initialState: ClassicalRegister,
        operations: [Identified<QuantumOperation>] = []
    ) {
        self.initialState = initialState
        self.operations = operations
    }

    /// Clears the program's operations and initial values.
    public mutating func clear() {
        initialState = .zero(count: initialState.count)
        operations = []
    }
}
