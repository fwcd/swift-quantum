public struct Identity: QuantumTransformationExpressionComponent {
    public let expression: QuantumTransformationExpression

    public init() {
        expression = .identity
    }

    public init(_ n: Int) {
        expression = .kronPow(.identity, n)
    }
}
