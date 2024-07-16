extension QuantumOracle {
    /// A convenience initializer for creating an oracle from a boolean function.
    ///
    /// This evaluates the function at all possible inputs and stores the outputs
    /// in a table, i.e. constructs a more dynamic representation of the function.
    ///
    /// We use Swift 5.9 variadic generics here. Unfortunately same type
    /// constraints (e.g. `each B == Bool`) are not supported yet (at least in
    /// 5.9), so we use the ``BooleanIsomorphic`` protocol as a workaround.
    public init<each B, each C>(
        type: QuantumOracleType = .standard,
        name: String = "f",
        _ function: (repeat each B) -> (repeat each C)
    ) where repeat each B: BooleanIsomorphic,
            repeat each C: BooleanIsomorphic {
        // We use a trick to count the arguments in the type parameter pack (since we cannot just call `.count` somewhere)
        // This is adapted from https://stackoverflow.com/a/77349310
        // This might become easier in Swift 6 with pack iteration: https://www.swift.org/blog/pack-iteration/
        var inputBits: Int = 0
        _ = (repeat ((each B).self, inputBits += 1))

        var allValues: [[Bool]] = []
        for binaryInput in 0..<(1 << inputBits) {
            let inputRegister = ClassicalRegister(value: binaryInput, count: inputBits)

            var i = 0
            let output = function(repeat ((each B)(booleanValue: inputRegister[i]), i += 1).0)
            
            var outputValues: [Bool] = []
            repeat outputValues.append((each output).booleanValue)

            allValues.append(outputValues)
        }

        self.init(type: type, name: name, values: allValues)
    }
}
