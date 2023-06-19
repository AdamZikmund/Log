import Foundation

extension Set where Element == Granularity {
    public static var none: Self {
        []
    }

    public static var all: Self {
        Element.all
    }

    /// Gets substracted set from all granularities with provided granularities
    /// - Parameter granularities: Set of granularities
    /// - Returns: Substracted granularities
    public static func without(
        _ granularities: Set<Granularity>
    ) -> Self {
        Element.without(granularities)
    }
}
