public protocol QuantumProgramComponent {
    var program: QuantumProgram { get }
}

extension QuantumProgram: QuantumProgramComponent {
    public var program: QuantumProgram { self }
}
