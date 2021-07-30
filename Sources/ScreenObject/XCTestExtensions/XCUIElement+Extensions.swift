/*
 ScreenObject

 Copyright (c) 2020 Devexperts LLC

 See https://code.devexperts.com for more open source projects
*/

import XCTest

@available(OSX 10.11, *)
@available(iOS 9.0, *)
@available(tvOS 9.1, *)
public extension XCUIElement {
    // Types delete symbols into the element.
    func clearText() {
        XCTContext.runActivity(named: "Clear \(self) text") { _ in
            let text = value as? String ?? ""

            if text.isEmpty {
                return
            }

            let deletes = Array(repeating: XCUIKeyboardKey.delete.rawValue, count: text.count)

            typeText(deletes.joined())
        }
    }

    #if !os(tvOS)
    // Sends a tap event at the element's coordinate. Useful if the regular .tap() fails.
    func tapUnhittable() {
        XCTContext.runActivity(named: "Tap \(self) by coordinate") { _ in
            coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.0)).tap()
        }
    }
    #endif

    /// Waits the specified amount of time for the element’s exists property to become false.
    ///
    /// - Returns: `false` if the timeout expires and the element still exists.
    func waitForDisappearance(timeout: TimeInterval = 3) -> Bool {
        return XCTContext.runActivity(named: "Waiting \(timeout)s for \(self) to disappear") { _ in
            let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == false"),
                                                        object: self)
            let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
            switch result {
            case .completed:
                return true
            default:
                return !exists
            }
        }
    }
}
