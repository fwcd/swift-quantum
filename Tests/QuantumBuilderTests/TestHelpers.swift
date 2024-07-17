import XCTest
import QuantumBuilder

func assert(_ lhs: QuantumProgram, equals rhs: QuantumProgram, file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(lhs.operations.map(\.identifiedValue), rhs.operations.map(\.identifiedValue), file: file, line: line)
}
