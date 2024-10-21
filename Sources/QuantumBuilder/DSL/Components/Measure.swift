public struct Measure: QuantumProgramComponent, Sendable {
    public var program: QuantumProgram {
        [.init(.measure)]
    }

    public init() {}
}
