import Foundation

public enum Granularity: Hashable {
    case date
    case symbol
    case file
    case line
    case column
    case function

    public static var all: Set<Granularity> {
        [date, symbol, file, line, column, function]
    }

    /// Gets substracted set from all granularities with provided granularities
    /// - Parameter granularities: Set of granularities
    /// - Returns: Substracted granularities
    public static func without(
        _ granularities: Set<Granularity>
    ) -> Set<Granularity> {
        all.subtracting(granularities)
    }
}
