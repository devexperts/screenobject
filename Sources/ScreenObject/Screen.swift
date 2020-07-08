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

    public func inApp(_ app: XCUIApplication) -> Screen {
        return Screen(of: app)
    }

    // swiftlint:disable force_cast
    public func on<T: Screen>(_ screen: T.Type) -> T {
        if self is T {
            return self as! T
        } else {
            return screen.init(of: app)
        }
    }
}
