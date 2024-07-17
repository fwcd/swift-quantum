import XCTest
import QuantumBuilder

final class QuantumBuilderTests: XCTestCase {
    func testEmpty() {
        assert(QuantumProgram {}, equals: [])
    }

    func testSimpleProgram() {
        assert(QuantumProgram {
            Hadamard()
            Measure()
        }, equals: [
            .init(.transform(.hadamard)),
            .init(.measure),
        ])
    }

    func testSimpleKronExpressions() {
        assert(QuantumProgram {
            Kron {
                Hadamard()
                Identity().kronPow(2)
            }
            Kron {
                Z()
                X()
                X()
            }
        }, equals: [
            .init(.transform(.kron(.hadamard, .kronPow(.identity, 2)))),
            .init(.transform(.kron(.kron(.z, .x), .x))),
        ])
    }
}
