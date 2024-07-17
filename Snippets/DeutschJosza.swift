import QuantumBuilder

enum FunctionKind: Hashable {
    case balanced
    case constant
}

func deutschJosza<each B: BoolConvertible>(_ f: (repeat each B) -> Bool) throws -> FunctionKind {
    let n = inputCount(of: f)

    let result = try QuantumProgram {
        Hadamard().kronPow(n)
        Oracle(type: .plusMinus, f)
        Hadamard().kronPow(n)
        Measure()
    }.measuredState(for: .zero(count: n))

    return result.value == 0 ? .constant : .balanced
}

print(try deutschJosza { (_: Bool) in true })
print(try deutschJosza { (_: Bool, _: Bool, b) in b })
