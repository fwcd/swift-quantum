import Quantum

let program = QuantumProgram(
    operations: [
        .init(.transform(.hadamard)),
        .init(.measure),
    ]
)

for _ in 0..<8 {
    print(try program.measuredState(for: [false]))
}
