/// A protocol for types that are isomorphic to ``Bool``.
public protocol BooleanIsomorphic {
    /// The representation of the value as ``Bool``.
    var booleanValue: Bool { get set }

    /// Initializes the value from the ``Bool`` representation.
    init(booleanValue: Bool)
}

extension Bool: BooleanIsomorphic {
    public var booleanValue: Bool {
        get { self }
        set { self = newValue }
    }

    public init(booleanValue: Bool) {
        self = booleanValue
    }
}
