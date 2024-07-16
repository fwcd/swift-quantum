@resultBuilder
enum ArrayBuilder<Element> {
    static func buildExpression(_ expression: Element) -> [Element] {
        [expression]
    }

    static func buildExpression(_ expression: Element?) -> [Element] {
        expression.map { [$0] } ?? []
    }

    static func buildBlock(_ components: Element...) -> [Element] {
        components
    }

    static func buildOptional(_ component: [Element]?) -> [Element] {
        component ?? []
    }

    static func buildBlock(_ components: [Element]...) -> [Element] {
        components.flatMap { $0 }
    }

    static func buildEither(first component: [Element]) -> [Element] {
        component
    }

    static func buildEither(second component: [Element]) -> [Element] {
        component
    }
}
