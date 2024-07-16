/// A protocol for things that can be expressed as LaTeX math expressions.
public protocol LaTeXConvertible {
    /// A LaTeX math expression encoding this value.
    var latex: String { get }
}
