// We use a trick to count the arguments in the type parameter pack (since we cannot just call `.count` somewhere)
// This is adapted from https://stackoverflow.com/a/77349310
// This might become easier in Swift 6 with pack iteration: https://www.swift.org/blog/pack-iteration/

/// Counts the number of function parameters.
public func inputCount<each B, each C>(of f: (repeat each B) -> (repeat each C)) -> Int {
    var count: Int = 0
    _ = (repeat ((each B).self, count += 1))
    return count
}

/// Counts the number of elements in the return tuple.
public func outputCount<each B, each C>(of f: (repeat each B) -> (repeat each C)) -> Int {
    var count: Int = 0
    _ = (repeat ((each C).self, count += 1))
    return count
}
