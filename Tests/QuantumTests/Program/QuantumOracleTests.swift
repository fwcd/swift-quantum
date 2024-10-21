import Testing
import Quantum

struct QuantumOracleTests {
    @Test func functionInitialization() {
        // Unfortunately, the lack of same-type constraints in Swift 5.9's variadic generics
        // poses some problems for type-inference, so we have to specify `Bool` explicitly.
        // This might get better with https://github.com/swiftlang/swift/pull/70227, with
        // which we could just replace `BoolConvertible` fully (hopefully?)

        #expect(QuantumOracle { () }.values == [[]])
        #expect(QuantumOracle { (b: Bool) in b }.values == [[false], [true]])
        #expect(QuantumOracle { $0 || $1 }.values == [[false], [true], [true], [true]])
        #expect(QuantumOracle { $0 && $1 }.values == [[false], [false], [false], [true]])
        #expect(QuantumOracle { (b: Bool, c: Bool) in (b, c) }.values == [[false, false], [false, true], [true, false], [true, true]])
    }

    @Test func standardEncoding() {
        expect(Matrix(QuantumOracle { $0 && $1 }), equals: [
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

    @Test func plusMinusEncoding() {
        expect(Matrix(QuantumOracle(type: .plusMinus) { $0 && $1 }), equals: [
            [1, 0, 0, 0],
            [0, 1, 0, 0],
            [0, 0, 1, 0],
            [0, 0, 0, -1],
        ])
    }
}

