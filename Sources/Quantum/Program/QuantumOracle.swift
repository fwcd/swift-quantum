/// An encoding of a classical function as quantum transformation.
public struct QuantumOracle: Codable, Hashable, LaTeXConvertible {
    /// The type of encoding, determining how a quantum transformation should be derived.
    public var type: QuantumOracleType
    /// The name of the function, for formatting purposes.
    public var name: String
    /// The truth-table for the classical function represented by this oracle.
    public var values: [[Bool]]

    public var latex: String {
        "O_{\(name)}"
    }

    public init(
        type: QuantumOracleType = .standard,
        name: String = "f",
        values: [[Bool]]
    ) {
        self.type = type
        self.name = name
        self.values = values
    }
}

extension Matrix {
    public init(_ oracle: QuantumOracle) {
        switch oracle.type {
        case .standard:
            fatalError("TODO")
        case .plusMinus:
            fatalError("TODO")
        }
    }
}
