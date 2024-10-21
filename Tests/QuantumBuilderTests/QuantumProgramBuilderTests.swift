import Testing
import QuantumBuilder

struct QuantumBuilderTests {
    @Test func empty() {
        expect(QuantumProgram {}, equals: [])
    }

    @Test func simpleProgram() {
        expect(QuantumProgram {
            Hadamard()
            Measure()
        }, equals: [
            .init(.transform(.hadamard)),
            .init(.measure),
        ])
    }

    @Test func simpleKronExpressions() {
        expect(QuantumProgram {
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
