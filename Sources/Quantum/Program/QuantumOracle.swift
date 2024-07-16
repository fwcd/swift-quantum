/// An encoding of a classical function as quantum transformation.
public struct QuantumOracle: Codable, Hashable, LaTeXConvertible {
    /// The type of encoding, determining how a quantum transformation should be derived.
    public var type: QuantumOracleType
    /// The name of the function, for formatting purposes.
    public var name: String
    /// The truth-table for the classical function represented by this oracle.
    public var values: [[Bool]]

    /// The dimension of the input, i.e. `pow(2, inputBitCount)`
    public var inputDimension: Int {
        values.count
    }

    /// The number of bits in the input.
    public var inputBitCount: Int {
        inputDimension.trailingZeroBitCount
    }

    /// The number of bits in the output.
    public var outputBitCount: Int {
        values[0].count
    }

    public var latex: String {
        "O_{\(name)}"
    }

    public init(
        type: QuantumOracleType = .standard,
        name: String = "f",
        values: [[Bool]]
    ) {
        precondition(!values.isEmpty, "Quantum oracle values (truth table) must not be empty")
        precondition(values.count.isPowerOfTwo, "Dimension of quantum oracle values (truth table) is not power of two: \(values.count)")
        precondition(values.allSatisfy { $0.count == values[0].count }, "Number of output bits must be the same for all inputs: \(values.map(\.count))")

        self.type = type
        self.name = name
        self.values = values
    }
}

extension Matrix {
    public init(_ oracle: QuantumOracle) {
        switch oracle.type {
        case .standard:
            let size = 1 << (oracle.inputBitCount + oracle.outputBitCount)
            self = .zero(size, size)

            for b in 0..<(1 << oracle.inputBitCount) {
                for c in 0..<(1 << oracle.outputBitCount) {
                    let input = (b << oracle.inputBitCount) | c
                    let output = (b << oracle.inputBitCount) | (c ^ ClassicalRegister(oracle.values[b]).value)
                    self[output, input] = 1
                }
            }
        case .plusMinus:
            // TODO: Should this be a thrown error instead?
            precondition(oracle.outputBitCount == 1, "Plus-minus encoding is only supported for oracles with 1 output bit (i.e. those encoding boolean-valued functions)")

            let size = 1 << oracle.inputBitCount
            self = .zero(size, size)

            for b in 0..<size {
                self[b, b] = oracle.values[b][0] ? -1 : 1
            }
        }
    }
}
