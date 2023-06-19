import Foundation

public enum Level: Int {
    case debug
    case info
    case verbose
    case warning
    case severe
    case error
    case none

    var symbol: String {
        switch self {
        case .debug:
            return "💬"
        case .info:
            return "ℹ️"
        case .verbose:
            return "🔬"
        case .warning:
            return "⚠️"
        case .severe:
            return "🔥"
        case .error:
            return "‼️"
        case .none:
            return ""
        }
    }
}
