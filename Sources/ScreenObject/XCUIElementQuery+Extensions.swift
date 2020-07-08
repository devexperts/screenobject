/*
 ScreenObject

 Copyright (c) 2020 Devexperts LLC

 See https://code.devexperts.com for more open source projects
*/

import XCTest

@available(OSX 10.11, *)
@available(iOS 9.0, *)
@available(tvOS 9.1, *)
public extension XCUIElementQuery {

    // The last element that matches a query
    var lastMatch: XCUIElement {
        return element(boundBy: self.count - 1)
    }
}
