# Swift Quantum

[![Build](https://github.com/fwcd/swift-quantum/actions/workflows/build.yml/badge.svg)](https://github.com/fwcd/swift-quantum/actions/workflows/build.yml)
[![Docs](https://github.com/fwcd/swift-quantum/actions/workflows/docs.yml/badge.svg)](https://fwcd.github.io/swift-quantum/documentation/quantum)

A library for simulating quantum computations in Swift.

The library is split into two modules:

- `Quantum`, the main library
- `QuantumBuilder`, an ergonomic (result builder-based) DSL for expressing quantum compuations

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
