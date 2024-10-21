//
//  TestHelpers.swift
//  Quantum
//
//  Created on 13.06.24
//

import Testing
import Quantum

extension Double {
    func isApproximatelyEqual(to other: Self, accuracy: Double = 0.0001) -> Bool {
        abs(self - other) < accuracy
    }
}

func expect(_ lhs: Complex, equals rhs: Complex, _ message: String? = nil, sourceLocation: SourceLocation = #_sourceLocation) {
    #expect(lhs.real.isApproximatelyEqual(to: rhs.real), "\(message ?? "Re(\(lhs)) != Re(\(rhs))")", sourceLocation: sourceLocation)
    #expect(lhs.imag.isApproximatelyEqual(to: rhs.imag), "\(message ?? "Im(\(lhs)) != Im(\(rhs))")", sourceLocation: sourceLocation)
}

func expect(_ lhs: Matrix, equals rhs: Matrix, sourceLocation: SourceLocation = #_sourceLocation) {
    #expect(lhs.width == rhs.width, "Left height != right height", sourceLocation: sourceLocation)
    #expect(lhs.height == rhs.height, "Left width != right width", sourceLocation: sourceLocation)
    for i in 0..<lhs.height {
        for j in 0..<lhs.width {
            expect(lhs[i, j], equals: rhs[i, j], "Element at \(i), \(j) does not match", sourceLocation: sourceLocation)
        }
    }
}

func expect(_ lhs: Vector, equals rhs: Vector, sourceLocation: SourceLocation = #_sourceLocation) {
    #expect(lhs.count == rhs.count, "Left count != right count", sourceLocation: sourceLocation)
    for i in 0..<lhs.count {
        expect(lhs[i], equals: rhs[i], "Element at \(i) does not match", sourceLocation: sourceLocation)
    }
}
