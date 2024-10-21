public struct Identity: QuantumTransformationExpressionComponent, Sendable {
    public let expression: QuantumTransformationExpression

    public init() {
        expression = .identity
    }

    public init(_ n: Int) {
        expression = .kronPow(.identity, n)
    }
}
