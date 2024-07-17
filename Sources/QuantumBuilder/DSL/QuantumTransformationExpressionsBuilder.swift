@resultBuilder
public struct QuantumTransformationExpressionsBuilder {
    private init() {}

    public static func buildBlock<each C: QuantumTransformationExpressionComponent>(_ components: repeat each C) -> [QuantumTransformationExpression] {
        var expressions: [QuantumTransformationExpression] = []
        repeat expressions.append((each components).expression)
        return expressions
    }

    public static func buildBlock(_ components: [QuantumTransformationExpression]...) -> [QuantumTransformationExpression] {
        components.flatMap { $0 }
    }

    public static func buildArray(_ components: [[QuantumTransformationExpression]]) -> [QuantumTransformationExpression] {
        components.flatMap { $0 }
    }

    public static func buildEither(first component: [QuantumTransformationExpression]) -> [QuantumTransformationExpression] {
        component
    }

    public static func buildEither(second component: [QuantumTransformationExpression]) -> [QuantumTransformationExpression] {
        component
    }

    public static func buildOptional(_ component: [QuantumTransformationExpression]?) -> [QuantumTransformationExpression] {
        component ?? []
    }
}
