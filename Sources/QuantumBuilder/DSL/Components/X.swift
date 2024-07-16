public struct X: QuantumProgramComponent {
    public var program: QuantumProgram {
        [.init(.transform(.x))]
    }

    public init() {}
}
