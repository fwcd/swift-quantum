public struct Measure: QuantumProgramComponent {
    public var program: QuantumProgram {
        [.init(.measure)]
    }
}
