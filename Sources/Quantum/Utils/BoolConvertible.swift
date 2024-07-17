/// A protocol for types that are isomorphic to ``Bool``.
public protocol BoolConvertible {
    /// The representation of the value as ``Bool``.
    var booleanValue: Bool { get set }

    /// Initializes the value from the ``Bool`` representation.
    init(booleanValue: Bool)
}

extension Bool: BoolConvertible {
    public var booleanValue: Bool {
        get { self }
        set { self = newValue }
    }

    public init(booleanValue: Bool) {
        self = booleanValue
    }
}
