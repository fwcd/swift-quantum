import Testing
import QuantumBuilder

func expect(_ lhs: QuantumProgram, equals rhs: QuantumProgram, sourceLocation: SourceLocation = #_sourceLocation) {
    #expect(lhs.operations.map(\.identifiedValue) == rhs.operations.map(\.identifiedValue), sourceLocation: sourceLocation)
}
