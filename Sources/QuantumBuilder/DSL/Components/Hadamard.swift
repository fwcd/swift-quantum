public struct Hadamard: QuantumTransformationExpressionComponent, Sendable {
    public let expression: QuantumTransformationExpression

    public init() {
        expression = .hadamard
    }

    public init(_ n: Int) {
        expression = .kronPow(.hadamard, n)
    }
}
