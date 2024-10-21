//
//  QuantumStateTests.swift
//  Quantum
//
//  Created on 24.06.24
//

import Testing
import Quantum

struct QuantumStateTests {
    @Test func measurement() {
        #expect(QuantumState(value: 0b101, qubitCount: 3).measure() == [true, false, true])
        #expect(QuantumState(value: 0b101, qubitCount: 4).measure() == [false, true, false, true])
    }
}
