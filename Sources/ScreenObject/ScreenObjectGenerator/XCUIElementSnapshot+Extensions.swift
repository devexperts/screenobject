/*
 ScreenObject

 Copyright (c) 2020 Devexperts LLC

 See https://code.devexperts.com for more open source projects
*/

import XCTest

@available(OSX 10.11, *)
@available(iOS 9.0, *)
@available(tvOS 9.1, *)
extension XCUIElementSnapshot {
    var query: String? {
        guard elementType != .application,
            !label.contains("scroll bar") else {
            return nil
        }

        let variableName: String, matcher: String
        let voiceOverLabel = label.isEmpty ? title : label

        switch (identifier, voiceOverLabel) {
        case ("", ""),
             ("", voiceOverLabel) where voiceOverLabel.count >= 128:
            return nil
        case (identifier, ""):
            variableName = identifier
            matcher = identifier
        case ("", voiceOverLabel):
            variableName = voiceOverLabel
            matcher = voiceOverLabel
        default:
            variableName = voiceOverLabel.count < 40 ? voiceOverLabel : identifier
            matcher = identifier
        }

        let name = "\(variableName.lowerCamelCase.prefix(40))\(elementType.name)"
        let query = "app.\(elementType.queryProvider)[\"\(matcher.oneLine)\"]"

        return "var \(name): XCUIElement { \(query) }\n"
    }

    func queries(blockList: [XCUIElement.ElementType]) -> [String] {
        guard !blockList.contains(elementType),
            !(elementType == .menuBarItem && title == "Apple") else {
            return []
        }

        var queries: [String] = []

        if let query = query {
            queries = [query]
        }

        queries = children.map { $0.queries(blockList: blockList) }.reduce(queries, +)

        if [XCUIElement.ElementType.keyboard,
            .table, .collectionView, .scrollView,
            .statusBar, .navigationBar, .toolbar, .tabBar,
            .group, .touchBar, .menuBarItem].contains(elementType), !queries.isEmpty {
            queries = ["\n", "// \(elementType.name)\n"] + queries
        }
        return queries
    }
}
