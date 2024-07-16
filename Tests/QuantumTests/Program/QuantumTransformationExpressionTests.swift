import XCTest
import Quantum

final class QuantumTransformationExpressionTests: XCTestCase {
    func testLaTeX() {
        let cases: [(QuantumTransformationExpression, String, UInt)] = [
            (.x, "X", #line),
            (.y, "Y", #line),
            (.z, "Z", #line),
            (.kronPow(.hadamard, 3), "{H}^{\\otimes 3}", #line),
            (.kronPow(.kron(.x, .hadamard), 3), "{(X \\otimes H)}^{\\otimes 3}", #line),
            (.hadamard, "H", #line),
        ]

        for (expr, latex, line) in cases {
            XCTAssertEqual(expr.latex, latex, line: line)
        }
    }
}
