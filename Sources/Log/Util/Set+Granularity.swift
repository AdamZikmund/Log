import Foundation

extension Set where Element == Granularity {
    public static var none: Self {
        []
    }

    public static var all: Self {
        Element.all
    }

    public static func without(_ granularities: Set<Granularity>) -> Self {
        Element.without(granularities)
    }
}
