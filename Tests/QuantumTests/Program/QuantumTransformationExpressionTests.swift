import Testing
import Quantum

class QuantumTransformationExpressionTests {
    @Test func laTeX() {
        // TODO: Parameterized test

        let cases: [(QuantumTransformationExpression, String, SourceLocation)] = [
            (.x, "X", #_sourceLocation),
            (.y, "Y", #_sourceLocation),
            (.z, "Z", #_sourceLocation),
            (.kronPow(.hadamard, 3), "{H}^{\\otimes 3}", #_sourceLocation),
            (.kronPow(.kron(.x, .hadamard), 3), "{(X \\otimes H)}^{\\otimes 3}", #_sourceLocation),
            (.hadamard, "H", #_sourceLocation),
        ]

        for (expr, latex, sourceLocation) in cases {
            #expect(expr.latex == latex, sourceLocation: sourceLocation)
        }
    }
}
