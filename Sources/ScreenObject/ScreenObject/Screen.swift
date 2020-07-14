/*
 ScreenObject

 Copyright (c) 2020 Devexperts LLC

 See https://code.devexperts.com for more open source projects
*/

import XCTest

@available(OSX 10.11, *)
@available(iOS 9.0, *)
@available(tvOS 9.1, *)
open class Screen {
    public let app: XCUIApplication

    public required init(of app: XCUIApplication) {
        self.app = app
    }

    /// Returns the required ScreenObject of an app
    /// - Parameters:
    ///   - screen: A type of new ScreenObject. E.g. NewScreen.self
    ///   - newApp: An optional app if chain should change target application
    public func on<T: Screen>(_ screen: T.Type, of newApp: XCUIApplication? = nil) -> T {
        if let newApp = newApp {
            return screen.init(of: newApp)
        } else {
            return screen.init(of: app)
        }
    }
}
