import XCTest
import QuantumBuilder

final class QuantumBuilderTests: XCTestCase {
    func testEmpty() {
        assert(QuantumProgram {}, equals: [])
    }

    func testBasic() {
        assert(QuantumProgram {
            Hadamard()
            Measure()
        }, equals: [
            .init(.transform(.hadamard)),
            .init(.measure),
        ])
    }
}
