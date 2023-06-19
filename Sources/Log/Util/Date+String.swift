import Foundation

extension Date {
    /// Formats date using given formatter
    /// - Parameter formatter: Date formatter
    /// - Returns: Formatted string
    func format(with formatter: DateFormatter) -> String {
        formatter.string(from: self)
    }
}
