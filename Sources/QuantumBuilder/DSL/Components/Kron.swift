public struct Kron: QuantumTransformationExpressionComponent {
    public let expression: QuantumTransformationExpression

    public init(
        @QuantumTransformationExpressionsBuilder _ factors: () -> [QuantumTransformationExpression]
    ) {
        let factors = factors()
        precondition(!factors.isEmpty, "Kron requires at least one factor")
        expression = factors.reduce1 { .kron($0, $1) }!
    }
}

extension QuantumTransformationExpressionComponent {
    public func kron(_ factor: () -> some QuantumTransformationExpressionComponent) -> Kron {
        Kron {
            self
            factor()
        }
    }
}
