import QuantumBuilder

enum FunctionKind: Hashable {
    case balanced
    case constant
}

func deutschJosza(_ f: (Bool, Bool, Bool) -> Bool) throws -> FunctionKind {
    let program = QuantumProgram {
        Hadamard().kronPow(3)
        Oracle(type: .plusMinus, f)
        Hadamard().kronPow(3)
        Measure()
    }
    let result = try program.measuredState(for: [false, false, false])
    return result.value == 0 ? .constant : .balanced
}

print(try deutschJosza { _, _, _ in true })
print(try deutschJosza { _, _, b in b })
