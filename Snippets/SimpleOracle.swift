import QuantumBuilder

let program = QuantumProgram {
    Oracle { (b: Bool) in
        !b
    }
    Measure()
}

print(try program.measuredState(for: [false]))
