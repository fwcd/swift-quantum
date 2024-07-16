//
//  Sequence+Extensions.swift
//  Quantum
//
//  Created on 25.06.24
//

import Foundation

extension Sequence {
    /// Reduces/folds with the given combining closure and returns `nil` if empty.
    func reduce1(_ combiner: (Element, Element) throws -> Element) rethrows -> Element? {
        var iterator = makeIterator()
        guard var result = iterator.next() else { return nil }
        while let value = iterator.next() {
            result = try combiner(result, value)
        }
        return result
    }
    
    /// Reduces/folds with intermediate values.
    func scan<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) throws -> Result) rethrows -> [Result] {
        var results: [Result] = [initialResult]
        for value in self {
            results.append(try nextPartialResult(results.last!, value))
        }
        return results
    }
}
