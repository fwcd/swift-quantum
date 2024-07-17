public struct Hadamard: QuantumTransformationExpressionComponent {
    public let expression: QuantumTransformationExpression

    public init() {
        expression = .hadamard
    }

    public init(_ n: Int) {
        expression = .kronPow(.hadamard, n)
    }
}
