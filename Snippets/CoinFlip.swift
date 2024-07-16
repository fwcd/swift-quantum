import Quantum

let program: QuantumProgram = [
    .init(.transform(.hadamard)),
    .init(.measure),
]

for _ in 0..<8 {
    print(try program.measuredState(for: [false]))
}
