import QuantumBuilder
import Foundation

import SwiftUI

func grover<each B: BoolConvertible>(_ f: (repeat each B) -> Bool) throws -> ClassicalState {
    let n = inputCount(of: f)
    let theta = acos(1 - 1 / Double(1 << n))
    let rounds = Int((.pi / (4 * theta) - 0.5).rounded())

    let result = try QuantumProgram {
        Hadamard().kronPow(n)
        for _ in 0..<rounds {
            // Reflect around |+^n>
            Hadamard().kronPow(n)
            Oracle(type: .plusMinus, n) {
                [$0.value != 0]
            }
            Hadamard().kronPow(n)
            // Reflect through |a>
            Oracle(type: .plusMinus, f)
        }
        Measure()
    }.measuredState(for: .zero(count: n))

    return result
}

for _ in 0..<8 {
    print(try grover { ($0, $1, $2, $3, $4) == (false, true, false, true, true) })
}
