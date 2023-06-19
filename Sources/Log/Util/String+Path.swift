import Foundation

extension String {
    /// Gets last path component from string
    var lastPathComponent: Self {
        components(separatedBy: "/").last ?? ""
    }
}
