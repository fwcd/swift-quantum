//
//  QuantumProgramError.swift
//  Quantum
//
//  Created on 24.06.24
//

import Foundation

/// An error during execution of a ``QuantumProgram``.
public struct QuantumProgramError: Error {
    /// The id of the operation that caused the error.
    public var operationId: UUID
    /// A human-readable description of the error.
    public var description: String
}
