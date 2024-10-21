//
//  ClassicalStateTests.swift
//  Quantum
//
//  Created on 24.06.24
//

import Testing
import Quantum

struct ClassicalStateTests {
    @Test func value() {
        #expect(ClassicalState(value: 0, count: 1).rawValue == [false])
        #expect(ClassicalState(value: 0b01, count: 2).rawValue == [false, true])
        #expect(ClassicalState(value: 0b110, count: 4).rawValue == [false, true, true, false])
        
        #expect(ClassicalState(value: 0b1, count: 1).value == 1)
        #expect(ClassicalState(value: 0b110, count: 3).value == 6)
        #expect(ClassicalState(value: 0b111, count: 4).value == 7)
    }
}
