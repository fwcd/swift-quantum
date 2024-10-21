/// The type of encoding, determining how a classical function should be turned
/// into a quantum transformation (i.e. a unitary transformation).
public enum QuantumOracleType: Codable, Hashable, Sendable {
    /// The standard encoding. Operates on n + m bits.
    ///
    /// This encodes `f: {0, 1}^n -> {0, 1}^m` as `O(|b> |c>) = |b> |c XOR f(b)>`.
    case standard
    /// The plus-minus/sign encoding. Operates on n bits and requires the
    /// function to only output a single bit (i.e. be boolean-valued).
    ///
    /// This encodes `f: {0, 1}^n -> {0, 1}` as `O(|b>) = (-1)^f(b) |b>`.
    case plusMinus
}
