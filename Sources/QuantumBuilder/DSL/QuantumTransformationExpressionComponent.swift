public protocol QuantumTransformationExpressionComponent: QuantumProgramComponent {
    var expression: QuantumTransformationExpression { get }
}

extension QuantumTransformationExpressionComponent { // conformance to QuantumProgramComponent
    public var program: QuantumProgram { QuantumProgram(operations: [.init(.transform(expression))]) }
}

extension QuantumTransformationExpression: QuantumTransformationExpressionComponent {
    public var expression: QuantumTransformationExpression { self }
}

extension Matrix: QuantumTransformationExpressionComponent {
    public var expression: QuantumTransformationExpression { .matrix(self) }
}
