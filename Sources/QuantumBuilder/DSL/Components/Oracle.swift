public struct Oracle: QuantumTransformationExpressionComponent, Sendable {
    public var expression: QuantumTransformationExpression {
        .oracle(wrappedOracle)
    }

    private let wrappedOracle: QuantumOracle

    public init(_ wrappedOracle: QuantumOracle) {
        self.wrappedOracle = wrappedOracle
    }

    public init(
        type: QuantumOracleType = .standard,
        name: String = "f",
        values: [[Bool]]
    ) {
        self.init(.init(type: type, name: name, values: values))
    }

    public init(
        type: QuantumOracleType = .standard,
        name: String = "f",
        _ inputBitCount: Int,
        _ function: (ClassicalState) -> ClassicalState
    ) {
        self.init(.init(type: type, name: name, inputBitCount, function))
    }

    public init<each B, each C>(
        type: QuantumOracleType = .standard,
        name: String = "f",
        _ function: (repeat each B) -> (repeat each C)
    ) where repeat each B: BoolConvertible,
            repeat each C: BoolConvertible {
        self.init(.init(type: type, name: name, function))
    }
}
