import QuantumBuilder

let program = QuantumProgram {
    Hadamard()
    Measure()
}

for _ in 0..<8 {
    print(try program.measuredState(for: [false]))
}
