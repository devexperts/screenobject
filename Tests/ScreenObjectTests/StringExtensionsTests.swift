/*
 ScreenObject

 Copyright (c) 2020 Devexperts LLC

 See https://code.devexperts.com for more open source projects
*/

import XCTest
@testable import ScreenObject

class StringExtensionsTests: XCTestCase {

    func testNormalised() {
        // Replacing symbols
        XCTAssertEqual("100$".normalised, "100 Dollar ")
        XCTAssertEqual("test@example.com".normalised, "test At example Dot com")
        XCTAssertEqual("-10.6%".normalised, " Minus 10 Dot 6 Percent ")
        XCTAssertEqual("#stayhome".normalised, " Hash stayhome")
        XCTAssertEqual("M&Ms M+Ms M/Ms".normalised, "M And Ms M Plus Ms M Slash Ms")
        XCTAssertEqual("k_i = 11\n/ 20".normalised, "k i  11  Slash  20")

        // Filtering symbols
        XCTAssertEqual("(x * y) = x times y".normalised, "x  y  x times y")

        // No action needed
        XCTAssertEqual("Devexperts 2020".normalised, "Devexperts 2020")

        // Empty string
        XCTAssertEqual("".normalised, "")
    }

    func testLowercaseFirstLetter() {
        // Basic cases
        XCTAssertEqual("One Two Three".lowercaseFirstLetter, "one Two Three")
        XCTAssertEqual("RDP".lowercaseFirstLetter, "rDP")
        XCTAssertEqual("Кириллица".lowercaseFirstLetter, "кириллица")

        // No action needed
        XCTAssertEqual("iPadOS is based on iOS".lowercaseFirstLetter, "iPadOS is based on iOS")
        XCTAssertEqual("24/03/2020".lowercaseFirstLetter, "24/03/2020")

        // Empty string
        XCTAssertEqual("".lowercaseFirstLetter, "")
    }

    func testIsAllCapitals() {
        // Basic cases
        XCTAssertTrue("SSH".isAllCapitals)
        XCTAssertTrue("BEN10".isAllCapitals)
        XCTAssertFalse("cd $HOME".isAllCapitals)
        XCTAssertFalse("echo".isAllCapitals)

        // Empty string
        XCTAssertTrue("".isAllCapitals)
    }

    func testUpperCamelCase() {
        // Basic cases
        XCTAssertEqual("one two three".upperCamelCase, "OneTwoThree")
        XCTAssertEqual("One Two Three".upperCamelCase, "OneTwoThree")
        XCTAssertEqual("ONE TWO THREE".upperCamelCase, "OneTwoThree")
        XCTAssertEqual("1 2 3".upperCamelCase, "The123")
        XCTAssertEqual("newReminderButton".upperCamelCase, "NewReminderButton")

        // No action needed
        XCTAssertEqual("NewReminderButton".upperCamelCase, "NewReminderButton")
        XCTAssertEqual("Fine".upperCamelCase, "Fine")

        // Empty string
        XCTAssertEqual("".upperCamelCase, "")
    }

    func testLowerCamelCase() {
        // Basic cases
        XCTAssertEqual("one two three".lowerCamelCase, "oneTwoThree")
        XCTAssertEqual("One Two Three".lowerCamelCase, "oneTwoThree")
        XCTAssertEqual("ONE TWO THREE".lowerCamelCase, "oneTwoThree")
        XCTAssertEqual("1 2 3".lowerCamelCase, "the123")
        XCTAssertEqual("NewReminderButton".lowerCamelCase, "newReminderButton")

        // No action needed
        XCTAssertEqual("newReminderButton".lowerCamelCase, "newReminderButton")
        XCTAssertEqual("fine".lowerCamelCase, "fine")

        // Empty string
        XCTAssertEqual("".lowerCamelCase, "")
    }

    func testOneLine() {
        let text = """
        hello
        world
        """
        XCTAssertEqual(text.oneLine, "hello\\nworld")

        // No action needed
        XCTAssertEqual("new\\nline".oneLine, "new\\nline")
        XCTAssertEqual("one line".oneLine, "one line")

        // Empty string
        XCTAssertEqual("".oneLine, "")
    }

    static var allTests = [
        ("testNormalised", testNormalised),
        ("testLowercaseFirstLetter", testLowercaseFirstLetter),
        ("testIsAllCapitals", testIsAllCapitals),
        ("testUpperCamelCase", testUpperCamelCase),
        ("testLowerCamelCase", testLowerCamelCase),
        ("testOneLine", testOneLine)
    ]
}
