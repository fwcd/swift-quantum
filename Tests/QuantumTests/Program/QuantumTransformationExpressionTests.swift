import Testing
import Quantum

class QuantumTransformationExpressionTests {
    @Test(arguments: [
        (QuantumTransformationExpression.x, "X"),
        (.y, "Y"),
        (.z, "Z"),
        (.kronPow(.hadamard, 3), "{H}^{\\otimes 3}"),
        (.kronPow(.kron(.x, .hadamard), 3), "{(X \\otimes H)}^{\\otimes 3}"),
        (.hadamard, "H"),
    ]) func laTeXConversion(expression: QuantumTransformationExpression, latex: String) {
        #expect(expression.latex == latex)
    }
}
