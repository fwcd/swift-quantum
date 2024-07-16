# Swift Quantum

A library for simulating quantum computations in Swift.

> [!IMPORTANT]
> This library is still work-in-progress, so the API may change. Currently it is primarily geared towards use in a UI, hence the identifiable operations, but a rewrite to a more ergonomic API for scripting is planned.

## Example

```swift
import Quantum

let program = QuantumProgram(
    initialState: [false],
    operations: [
        .init(.transform(.hadamard)),
        .init(.measure),
    ]
)

for _ in 0..<8 {
    print(try program.measuredState)
}
```

To try this example, run

```sh
swift run CoinFlip
```

More examples can be found under [`Snippets`](Snippets).
