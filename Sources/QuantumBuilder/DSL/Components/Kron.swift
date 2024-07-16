public struct Kron: QuantumTransformationExpressionComponent {
    public let expression: QuantumTransformationExpression

    public init(
        @ArrayBuilder<any QuantumTransformationExpressionComponent> _ rawFactors: () -> [any QuantumTransformationExpressionComponent]
    ) {
        let factors = rawFactors().map(\.expression)
        precondition(!factors.isEmpty, "Kron requires at least one factor")
        expression = factors.reduce1 { .kron($0, $1) }!
    }
}
