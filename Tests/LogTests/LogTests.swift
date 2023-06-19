import XCTest
@testable import Log

final class LogTests: XCTestCase {
    func testLogDisabled() throws {
        Log.setIsEnabled(false)
        let message = Log.debug("debug")
        XCTAssertNil(message)
        XCTAssertTrue(Log.messages.isEmpty)
        Log.setIsEnabled(true)
    }

    func testSetDateFormatter() throws {
        let dateFormatter = DateFormatter()
        Log.setDateFormatter(dateFormatter)
        XCTAssertTrue(Log.shared.dateFormatter === dateFormatter)
    }

    func testLogEnabledForDebug() throws {
        Log.setLevel(.debug)
        let message = Log.debug("debug")
        XCTAssertNotNil(message)
    }

    func testLogDisabledForDebug() throws {
        Log.setLevel(.info)
        let message = Log.debug("debug")
        XCTAssertNil(message)
    }

    func testLogEnabledForInfo() throws {
        Log.setLevel(.info)
        let message = Log.info("info")
        XCTAssertNotNil(message)
    }

    func testLogDisabledForInfo() throws {
        Log.setLevel(.verbose)
        let message = Log.info("info")
        XCTAssertNil(message)
    }

    func testLogEnabledForVerbose() throws {
        Log.setLevel(.verbose)
        let message = Log.verbose("verbose")
        XCTAssertNotNil(message)
    }

    func testLogDisabledForVerbose() throws {
        Log.setLevel(.warning)
        let message = Log.verbose("verbose")
        XCTAssertNil(message)
    }

    func testLogEnabledForWarning() throws {
        Log.setLevel(.warning)
        let message = Log.warning("warning")
        XCTAssertNotNil(message)
    }

    func testLogDisabledForWarning() throws {
        Log.setLevel(.severe)
        let message = Log.warning("warning")
        XCTAssertNil(message)
    }

    func testLogEnabledForSevere() throws {
        Log.setLevel(.severe)
        let message = Log.severe("severe")
        XCTAssertNotNil(message)
    }

    func testLogDisabledForSevere() throws {
        Log.setLevel(.error)
        let message = Log.severe("severe")
        XCTAssertNil(message)
    }

    func testLogEnabledForError() throws {
        Log.setLevel(.error)
        let message = Log.error("error")
        XCTAssertNotNil(message)
    }

    func testLogDisabledForError() throws {
        Log.setLevel(.none)
        let message = Log.error("error")
        XCTAssertNil(message)
    }

#if os(iOS)
    func testMemoryWarning() throws {
        Log.shared.level = .debug
        Log.debug("Memory warning")
        XCTAssertFalse(Log.messages.isEmpty)
        NotificationCenter
            .default
            .post(
                name: UIApplication.didReceiveMemoryWarningNotification,
                object: nil
            )
        XCTAssertTrue(Log.messages.isEmpty)
    }
#endif

    func testMessagesBuffer() throws {
        Log.shared.level = .debug
        Log.clearMessages()
        Log.debug("First message")
        Log.debug("Second message")
        Log.debug("Third message")
        XCTAssertEqual(Log.messages.count, 3)
    }

    func testNoneGranularity() throws {
        Log.shared.level = .debug
        let firstMessage = Log.debug("First message", granularity: .none)
        let secondMessage = Log.debug("Second message", granularity: .without(.all))
        XCTAssertEqual(firstMessage, "First message")
        XCTAssertEqual(secondMessage, "Second message")
    }
}
