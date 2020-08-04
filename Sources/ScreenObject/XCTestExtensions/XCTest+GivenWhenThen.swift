/*
 ScreenObject

 Copyright (c) 2020 Devexperts LLC

 See https://code.devexperts.com for more open source projects
*/

import XCTest

public extension XCTest {
    func given(_ note: String, block: () throws -> Void) rethrows {
        try step(named: "[Given] " + note, block: block)
    }

    func when(_ note: String, block: () throws -> Void) rethrows {
        try step(named: "[When] " + note, block: block)
    }

    func then(_ note: String, block: () throws -> Void) rethrows {
        try step(named: "[Then] " + note, block: block)
    }

    func step<Result>(named: String, block: () throws -> Result) rethrows {
        _ = try XCTContext.runActivity(named: named) { _ in try block() }
    }
}
