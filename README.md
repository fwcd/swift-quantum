# Swift Quantum

A library for simulating quantum computations in Swift.

The library is split into two modules:

- `Quantum`, the main library
- `QuantumBuilder`, a result builder-based DSL (that leverages modern Swift features like variadic generics/parameter packs)

`QuantumBuilder` re-exports `Quantum`, so you only have to import one of the two, depending on what you need.

## Example

```swift
import QuantumBuilder

let program = QuantumProgram {
    Hadamard()
    Measure()
}

for _ in 0..<8 {
    print(try program.measuredState(for: [false]))
}
```

To try this example, run

```sh
swift run CoinFlip
```

An example output would be:

```
[true]
[true]
[true]
[false]
[false]
[true]
[false]
[true]
```

More examples can be found under [`Snippets`](Snippets).
