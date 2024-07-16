import QuantumBuilder

let program = QuantumProgram {
    // A plus-minus oracle that encodes NOT.
    Oracle(type: .plusMinus) { (b: Bool) in
        !b
    }
}

for input in [false, true] {
    print(try program.finalState(for: [input]))
}
