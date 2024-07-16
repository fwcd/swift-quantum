//
//  QuantumOperation.swift
//  Quantum
//
//  Created on 24.06.24
//

/// A step in a quantum program.
public enum QuantumOperation: Hashable, Codable {
    case transform(QuantumTransformationExpression)
    case measure
    
    // TODO: Partial measurements
    
    /// A simplified version of the operation.
    public var simplified: Self {
        switch self {
        case .transform(let transformation): .transform(transformation.simplified)
        case .measure: .measure
        }
    }
}
