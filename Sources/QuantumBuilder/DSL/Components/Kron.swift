public struct Kron: QuantumTransformationExpressionComponent {
    public let expression: QuantumTransformationExpression

    public init(factors: [QuantumTransformationExpression]) {
        precondition(!factors.isEmpty, "Kron requires at least one factor")
        expression = factors.reduce1 { .kron($0, $1) }!
    }

    public init(@QuantumTransformationExpressionsBuilder _ factors: () -> [QuantumTransformationExpression]) {
        self.init(factors: factors())
    }
}

extension QuantumTransformationExpressionComponent {
    public func kron(@QuantumTransformationExpressionsBuilder _ factors: () -> [QuantumTransformationExpression]) -> Kron {
        Kron(factors: [expression] + factors())
    }
}
