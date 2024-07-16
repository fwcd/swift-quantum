@resultBuilder
public struct QuantumProgramBuilder {
    // We use Swift 5.9's variadic generics here (parameter packs)

    public static func buildBlock<each C: QuantumProgramComponent>(_ component: repeat each C) -> QuantumProgram {
        var program: QuantumProgram = []
        repeat program += (each component).program
        return program
    }
}
