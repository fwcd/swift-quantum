//
//  Identified.swift
//  Quantum
//
//  Created on 24.06.24
//

import Foundation

/// A value with an associated UUID.
@propertyWrapper
@dynamicMemberLookup
public struct Identified<Value>: Identifiable {
    /// The associated UUID.
    public let id: UUID
    /// The wrapped value.
    public var wrappedValue: Value
    
    /// A synonym for wrappedValue to disambiguate when accessed e.g. through a
    /// SwiftUI `Binding`.
    public var identifiedValue: Value {
        get { wrappedValue }
        set { wrappedValue = newValue }
    }

    public init(id: UUID = UUID(), wrappedValue: Value) {
        self.id = id
        self.wrappedValue = wrappedValue
    }
    
    public init(_ wrappedValue: Value) {
        self.init(wrappedValue: wrappedValue)
    }
    
    public subscript<Member>(dynamicMember dynamicMember: WritableKeyPath<Value, Member>) -> Member {
        get { wrappedValue[keyPath: dynamicMember] }
        set { wrappedValue[keyPath: dynamicMember] = newValue }
    }
}

extension Identified: Equatable where Value: Equatable {}
extension Identified: Hashable where Value: Hashable {}
extension Identified: Encodable where Value: Encodable {}
extension Identified: Decodable where Value: Decodable {}
extension Identified: Sendable where Value: Sendable {}
