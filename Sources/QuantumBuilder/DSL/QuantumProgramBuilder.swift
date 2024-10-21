@resultBuilder
public struct QuantumProgramBuilder: Sendable {
    private init() {}

    // We use Swift 5.9's variadic generics here (parameter packs)

    public static func buildBlock<each C: QuantumProgramComponent>(_ component: repeat each C) -> QuantumProgram {
        var program: QuantumProgram = []
        repeat program += (each component).program
        return program
    }

    public static func buildArray(_ components: [QuantumProgram]) -> QuantumProgram {
        QuantumProgram(operations: components.flatMap(\.operations))
    }

    public static func buildEither(first component: QuantumProgram) -> QuantumProgram {
        component
    }

    public static func buildEither(second component: QuantumProgram) -> QuantumProgram {
        component
    }

    public static func buildOptional(_ component: QuantumProgram?) -> QuantumProgram {
        component ?? .init()
    }
}

extension QuantumProgram {
    /// Initializer for constructing a ``QuantumProgram`` using result builders,
    /// mostly for convenience.
    public init(@QuantumProgramBuilder _ builder: () -> QuantumProgram) {
        self = builder()
    }
}
