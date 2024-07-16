public struct Hadamard: QuantumProgramComponent {
    public var program: QuantumProgram {
        [.init(.transform(.hadamard))]
    }
}

