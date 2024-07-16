public struct Oracle: QuantumProgramComponent {
    public var program: QuantumProgram {
        [.init(.transform(.oracle(wrappedOracle)))]
    }

    private let wrappedOracle: QuantumOracle

    public init(_ wrappedOracle: QuantumOracle) {
        self.wrappedOracle = wrappedOracle
    }

    public init<each B, each C>(
        type: QuantumOracleType = .standard,
        name: String = "f",
        _ function: (repeat each B) -> (repeat each C)
    ) where repeat each B: BooleanIsomorphic,
            repeat each C: BooleanIsomorphic {
        self.init(.init(type: type, name: name, function))
    }
}
