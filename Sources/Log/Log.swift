import Foundation

#if os(iOS)
import UIKit
#endif

final public class Log {
    // MARK: - Properties
    public static let shared = Log()
    public private(set) var messages = [String]()
    public var level = Level.debug

    public var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSZ"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }()

    // MARK: - Lifecycle
    /// Private init to prevent initialization
    private init() {
#if os(iOS)
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(didReceiveMemoryWarningNotificationHandler),
                name: UIApplication.didReceiveMemoryWarningNotification,
                object: nil
            )
#endif
    }

    deinit {
#if os(iOS)
        NotificationCenter
            .default
            .removeObserver(
                self,
                name: UIApplication.didReceiveMemoryWarningNotification,
                object: nil
            )
#endif
    }

    // MARK: - Private
    /// Checks if is logging enabled for given level
    /// - Parameter level: Logging level
    /// - Returns: True if is enabled and false if is not enabled
    private static func isLoggingEnabled(for level: Level) -> Bool {
#if DEBUG
        return level.rawValue >= shared.level.rawValue
#else
        return false
#endif
    }

    /// Handles memory warning by removing messages buffer
    @objc private func didReceiveMemoryWarningNotificationHandler() {
        messages = []
    }

    /// Logs debug message
    /// - Parameters:
    ///   - object: Logged object
    ///   - level: Log level
    ///   - description: Description of caller
    ///   - granularity: Granularity of printed informations
    private static func log(
        _ object: Any,
        level: Level,
        description: Description,
        granularity: Set<Granularity>
    ) -> String? {
        guard isLoggingEnabled(for: level) else { return nil }
        let message = buildMessage(
            object,
            level: level,
            description: description,
            granularity: granularity
        )
        shared.messages.append(message)
        print(message)
        return message
    }

    /// Build log message from provided data
    /// - Parameters:
    ///   - object: Logged object
    ///   - level: Log level
    ///   - description: Description of caller
    ///   - granularity: Granularity of printed informations
    /// - Returns: Formatted message
    private static func buildMessage(
        _ object: Any,
        level: Level,
        description: Description,
        granularity: Set<Granularity>
    ) -> String {
        var message = ""
        if granularity.contains(.date) {
            message += Date().format(with: shared.dateFormatter)
            message += " "
        }
        if granularity.contains(.symbol) {
            message += "[\(level.symbol)]"
        }
        if granularity.contains(.file) {
            message += "[\(description.file.lastPathComponent)]"
        }
        if granularity.contains(.line) {
            message += "[\(description.line)]"
        }
        if granularity.contains(.column) {
            message += "[\(description.column)]"
        }
        if granularity.contains(.function) {
            message += "[\(description.function)]"
        }
        if !granularity.isEmpty {
            message += " "
        }
        message += "\(object)"
        return message
    }

    // MARK: - Public
    /// Logs debug message
    /// - Parameters:
    ///   - object: Logged object
    ///   - file: File where logging was called
    ///   - line: Line where logging was called
    ///   - column: Column where logging was called
    ///   - function: Function in which logging was called
    ///   - granularity: Granularity of printed informations
    @discardableResult public static func debug(
        _ object: Any,
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function,
        granularity: Set<Granularity> = .all
    ) -> String? {
        log(
            object,
            level: .debug,
            description: .init(
                file: file,
                line: line,
                column: column,
                function: function
            ),
            granularity: granularity
        )
    }

    /// Logs info message
    /// - Parameters:
    ///   - object: Logged object
    ///   - file: File where logging was called
    ///   - line: Line where logging was called
    ///   - column: Column where logging was called
    ///   - function: Function in which logging was called
    ///   - granularity: Granularity of printed informations
    @discardableResult public static func info(
        _ object: Any,
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function,
        granularity: Set<Granularity> = .all
    ) -> String? {
        log(
            object,
            level: .info,
            description: .init(
                file: file,
                line: line,
                column: column,
                function: function
            ),
            granularity: granularity
        )
    }

    /// Logs verbose message
    /// - Parameters:
    ///   - object: Logged object
    ///   - file: File where logging was called
    ///   - line: Line where logging was called
    ///   - column: Column where logging was called
    ///   - function: Function in which logging was called
    ///   - granularity: Granularity of printed informations
    @discardableResult public static func verbose(
        _ object: Any,
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function,
        granularity: Set<Granularity> = .all
    ) -> String? {
        log(
            object,
            level: .verbose,
            description: .init(
                file: file,
                line: line,
                column: column,
                function: function
            ),
            granularity: granularity
        )
    }

    /// Logs warning message
    /// - Parameters:
    ///   - object: Logged object
    ///   - file: File where logging was called
    ///   - line: Line where logging was called
    ///   - column: Column where logging was called
    ///   - function: Function in which logging was called
    ///   - granularity: Granularity of printed informations
    @discardableResult public static func warning(
        _ object: Any,
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function,
        granularity: Set<Granularity> = .all
    ) -> String? {
        log(
            object,
            level: .warning,
            description: .init(
                file: file,
                line: line,
                column: column,
                function: function
            ),
            granularity: granularity
        )
    }

    /// Logs severe message
    /// - Parameters:
    ///   - object: Logged object
    ///   - file: File where logging was called
    ///   - line: Line where logging was called
    ///   - column: Column where logging was called
    ///   - function: Function in which logging was called
    ///   - granularity: Granularity of printed informations
    @discardableResult public static func severe(
        _ object: Any,
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function,
        granularity: Set<Granularity> = .all
    ) -> String? {
        log(
            object,
            level: .severe,
            description: .init(
                file: file,
                line: line,
                column: column,
                function: function
            ),
            granularity: granularity
        )
    }

    /// Logs error message
    /// - Parameters:
    ///   - object: Logged object
    ///   - file: File where logging was called
    ///   - line: Line where logging was called
    ///   - column: Column where logging was called
    ///   - function: Function in which logging was called
    ///   - granularity: Granularity of printed informations
    @discardableResult public static func error(
        _ object: Any,
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function,
        granularity: Set<Granularity> = .all
    ) -> String? {
        log(
            object,
            level: .error,
            description: .init(
                file: file,
                line: line,
                column: column,
                function: function
            ),
            granularity: granularity
        )
    }
}
