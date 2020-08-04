/*
 ScreenObject

 Copyright (c) 2020 Devexperts LLC

 See https://code.devexperts.com for more open source projects
*/

import XCTest

@available(OSX 10.11, *)
@available(iOS 9.0, *)
@available(tvOS 9.1, *)
public extension XCTest {
    /// Returns the required ScreenObject of an app
    /// - Parameters:
    ///   - screen: A type of new ScreenObject. E.g. NewScreen.self
    ///   - app: An app (equals to the target app by default)
    func on<T: Screen>(_ screen: T.Type, of app: XCUIApplication? = nil) -> T {
        if let app = app {
            return screen.init(of: app)
        } else {
            return screen.init(of: XCUIApplication())
        }
    }

    func addNote(_ note: String) {
        XCTContext.runActivity(named: note) { _ in }
    }
}
