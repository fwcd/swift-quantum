public protocol QuantumProgramComponent {
    var program: QuantumProgram { get }
}

extension QuantumProgram: QuantumProgramComponent {
    public var program: QuantumProgram { self }
}

extension Identified<QuantumOperation>: QuantumProgramComponent {
    public var program: QuantumProgram { QuantumProgram(operations: [self]) }
}

extension QuantumOperation: QuantumProgramComponent {
    public var program: QuantumProgram { QuantumProgram(operations: [.init(self)]) }
}
