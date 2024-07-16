import QuantumBuilder

let program = QuantumProgram {
    // A standard oracle that negates the input.
    // Note that this operates on 2 qubits.
    Oracle { (b: Bool) in
        !b
    }
    Measure()
}

for input in [false, true] {
    print(try program.measuredState(for: [input, false]))
}
