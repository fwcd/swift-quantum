//
//  QuantumProgramError.swift
//  Quantum
//
//  Created on 24.06.24
//

import Foundation

public struct QuantumProgramError: Error {
    public var operationId: UUID
    public var description: String
}
