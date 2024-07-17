# ``Quantum``

Simulate quantum computations in Swift

## Overview

The `Quantum` library provides a range of mathematical primitives, quantum gates and operators for representing, manipulating and simulating quantum algorithms.

## Topics

### Math

Numerical primitives for working with complex numbers and multidimensional data.

- ``Complex``
- ``Matrix``
- ``Vector``

### Program

The central quantum program model. Programs are represented as syntax trees that are evaluated on-demand. This representation simplifies both serialization and UI bindings.

- ``ComplexExpression``
- ``QuantumOperation``
- ``QuantumOracle``
- ``QuantumOracleType``
- ``QuantumProgram``
- ``QuantumProgramError``
- ``QuantumTransformationExpression``

### State

The representation of classical and quantum states. This is a high-level wrapper around ``Vector`` with domain-specific conveniences, e.g. for converting between binary representations or random sampling.

- ``ClassicalState``
- ``QuantumState``

### Utils

General utilities that are used in the public API of this library.

- ``BooleanIsomorphic``
- ``Identified``
- ``LaTeXConvertible``
