import QuantumBuilder

let program = QuantumProgram {
    Kron {
        Hadamard()
        Identity()
    }
    Kron {
        Z()
        X()
    }
    Measure()
}

for _ in 0..<8 {
    print(try program.measuredState(for: [false, false]))
}
