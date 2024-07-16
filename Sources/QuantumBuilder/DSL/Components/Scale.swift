public struct Scale: QuantumTransformationExpressionComponent {
    public let expression: QuantumTransformationExpression

    public init(
        _ factor: ComplexExpression,
        _ wrappedExpression: () -> some QuantumTransformationExpressionComponent
    ) {
        expression = .scale(factor, wrappedExpression().expression)
    }
}

extension QuantumTransformationExpressionComponent {
    public func scale(_ factor: ComplexExpression) -> Scale {
        Scale(factor) {
            self
        }
    }
}
