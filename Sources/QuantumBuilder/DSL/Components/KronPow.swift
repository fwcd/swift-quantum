public struct KronPow: QuantumTransformationExpressionComponent, Sendable {
    public let expression: QuantumTransformationExpression

    public init(
        _ n: Int,
        _ wrappedExpression: () -> some QuantumTransformationExpressionComponent
    ) {
        expression = .kronPow(wrappedExpression().expression, n)
    }
}

extension QuantumTransformationExpressionComponent {
    public func kronPow(_ n: Int) -> KronPow {
        KronPow(n) {
            self
        }
    }
}
