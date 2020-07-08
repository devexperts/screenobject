/*
 ScreenObject

 Copyright (c) 2020 Devexperts LLC

 See https://code.devexperts.com for more open source projects
*/

import XCTest

@available(OSX 10.11, *)
@available(iOS 9.0, *)
@available(tvOS 9.1, *)
public protocol XCUIElementAnyTypeQueryProvider {
    func descendants(matching type: XCUIElement.ElementType) -> XCUIElementQuery

}

@available(OSX 10.11, *)
@available(iOS 9.0, *)
@available(tvOS 9.1, *)
public extension XCUIElementTypeQueryProvider where Self: XCUIElementAnyTypeQueryProvider {
    // Returns a query for all descendants of any type
    var anyElements: XCUIElementQuery {
        return descendants(matching: .any)
    }
}

@available(OSX 10.11, *)
@available(iOS 9.0, *)
@available(tvOS 9.1, *)
extension XCUIElement: XCUIElementAnyTypeQueryProvider {}

@available(OSX 10.11, *)
@available(iOS 9.0, *)
@available(tvOS 9.1, *)
extension XCUIElementQuery: XCUIElementAnyTypeQueryProvider {}

// 'XCUIApplication' conforms to a protocol 'XCUIElementAnyTypeQueryProvider' automatically
