import XCTest
import Quantum

final class QuantumOracleTests: XCTestCase {
    func testFunctionInitialization() {
        // Unfortunately, the lack of same-type constraints in Swift 5.9's variadic generics
        // poses some problems for type-inference, so we have to specify `Bool` explicitly.
        // This might get better with https://github.com/swiftlang/swift/pull/70227, with
        // which we could just replace `BoolConvertible` fully (hopefully?)

        XCTAssertEqual(QuantumOracle { () }.values, [[]])
        XCTAssertEqual(QuantumOracle { (b: Bool) in b }.values, [[false], [true]])
        XCTAssertEqual(QuantumOracle { $0 || $1 }.values, [[false], [true], [true], [true]])
        XCTAssertEqual(QuantumOracle { $0 && $1 }.values, [[false], [false], [false], [true]])
        XCTAssertEqual(QuantumOracle { (b: Bool, c: Bool) in (b, c) }.values, [[false, false], [false, true], [true, false], [true, true]])
    }

    func testStandardEncoding() {
        assert(Matrix(QuantumOracle { $0 && $1 }), equals: [
            [1, 0, 0, 0, 0, 0, 0, 0],
            [0, 1, 0, 0, 0, 0, 0, 0],
            [0, 0, 1, 0, 0, 0, 0, 0],
            [0, 0, 0, 1, 0, 0, 0, 0],
            [0, 0, 0, 0, 1, 0, 0, 0],
            [0, 0, 0, 0, 0, 1, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 1],
            [0, 0, 0, 0, 0, 0, 1, 0],
        ])
    }

    func testPlusMinusEncoding() {
        assert(Matrix(QuantumOracle(type: .plusMinus) { $0 && $1 }), equals: [
            [1, 0, 0, 0],
            [0, 1, 0, 0],
            [0, 0, 1, 0],
            [0, 0, 0, -1],
        ])
    }
}

