extension QuantumProgram {
    /// Initializer for constructing a QuantumProgram using result builders,
    /// mostly for convenience.
    public init(@QuantumProgramBuilder _ builder: () -> QuantumProgram) {
        self = builder()
    }
}