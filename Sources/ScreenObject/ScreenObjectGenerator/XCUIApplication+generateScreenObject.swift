/*
 ScreenObject

 Copyright (c) 2020 Devexperts LLC

 See https://code.devexperts.com for more open source projects
*/

import XCTest

@available(OSX 10.11, *)
@available(iOS 9.0, *)
@available(tvOS 9.1, *)
public extension XCUIApplication {
    /// Generate and returns the ScreenObject of the current screen or window(s)
    /// - Parameters:
    ///   - blockList: An optional array of element types that should not be included.
    ///   The macOS menu bars are hidden by default.
    func generateScreenObject(blockList: [XCUIElement.ElementType] = [.menuBar],
                              file: StaticString = #file,
                              line: UInt = #line) -> XCTAttachment {

        return XCTContext.runActivity(named: "Generate a ScreenObject") { _ in
            let navBar = navigationBars.firstMatch
            let screenName = (navBar.exists ? navBar.identifier.upperCamelCase : "New".placeholder) + "Screen"
            let elements: String

            do {
                let queries = try snapshot().queries
                elements = queries(blockList).map { "    \($0)" }.joined()
            } catch {
                let error = "Unable to get app's snapshot"
                XCTFail(error, file: file, line: line)
                elements = "    // " + error + "\n"
            }

            let screenObject = """
            //
            // \(screenName).swift
            // AUT: \(name)
            //
            // This file is generated with ScreenObject package.
            // https://github.com/devexperts/screenobject
            //

            import XCTest
            import ScreenObject

            final class \(screenName): Screen {
                // MARK: - Elements
            \(elements)
                // MARK: - Steps
                //@discardableResult
                //func \("someAction".placeholder)() -> Self {
                //    XCTContext.runActivity(named: "\("Do Some Action".placeholder)") { _ in
                //
                //    }
                //    return self
                //}
            }

            """

            let attachment = XCTAttachment(string: screenObject)
            attachment.name = "Generated ScreenObject of the \(screenName)"
            attachment.lifetime = .keepAlways

            return attachment
        }
    }

    // Returns the name of the app
    var name: String {
        #if os(iOS) || os(tvOS)
            return label
        #elseif os(macOS)
            return title
        #else
            return label + title
        #endif
    }
}
