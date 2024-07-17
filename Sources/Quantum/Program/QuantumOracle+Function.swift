extension QuantumOracle {
    /// A convenience initializer for creating an oracle from a boolean function.
    ///
    /// This evaluates the function at all possible inputs and stores the outputs
    /// in a table, i.e. constructs a more dynamic representation of the function.
    ///
    /// We use Swift 5.9 variadic generics here. Unfortunately same type
    /// constraints (e.g. `each B == Bool`) are not supported yet (at least in
    /// 5.9), so we use the ``BoolConvertible`` protocol as a workaround.
    public init<each B: BoolConvertible, each C: BoolConvertible>(
        type: QuantumOracleType = .standard,
        name: String = "f",
        _ function: (repeat each B) -> (repeat each C)
     ) {
        let inputBitCount = inputCount(of: function)

        var allValues: [[Bool]] = []
        for binaryInput in 0..<(1 << inputBitCount) {
            let input = ClassicalState(value: binaryInput, count: inputBitCount)

            var i = 0
            let output = function(repeat ((each B)(booleanValue: input[i]), i += 1).0)
            
            var outputValues: [Bool] = []
            repeat outputValues.append((each output).booleanValue)

            allValues.append(outputValues)
        }

        self.init(type: type, name: name, values: allValues)
    }
}
