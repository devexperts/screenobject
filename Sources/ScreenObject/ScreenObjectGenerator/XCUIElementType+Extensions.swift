/*
 ScreenObject

 Copyright (c) 2020 Devexperts LLC

 See https://code.devexperts.com for more open source projects
*/

import XCTest

@available(OSX 10.11, *)
@available(iOS 9.0, *)
@available(tvOS 9.1, *)
extension XCUIElement.ElementType {
    static var names = [
        "AnyElement", "OtherElement", "Application", "Group", "Window", "Sheet", "Drawer",
        "Alert", "Dialog", "Button", "RadioButton", "RadioGroup", "CheckBox",
        "DisclosureTriangle", "PopUpButton", "ComboBox", "MenuButton", "ToolbarButton",
        "Popover", "Keyboard", "Key", "NavigationBar", "TabBar", "TabGroup", "Toolbar",
        "StatusBar", "Table", "TableRow", "TableColumn", "Outline", "OutlineRow", "Browser",
        "CollectionView", "Slider", "PageIndicator", "ProgressIndicator", "ActivityIndicator",
        "SegmentedControl", "Picker", "PickerWheel", "Switch", "Toggle", "Link", "Image",
        "Icon", "SearchField", "ScrollView", "ScrollBar", "StaticText", "TextField",
        "SecureTextField", "DatePicker", "TextView", "Menu", "MenuItem", "MenuBar",
        "MenuBarItem", "Map", "WebView", "IncrementArrow", "DecrementArrow", "Timeline",
        "RatingIndicator", "ValueIndicator", "SplitGroup", "Splitter", "RelevanceIndicator",
        "ColorWell", "HelpTag", "Matte", "DockItem", "Ruler", "RulerMarker", "Grid",
        "LevelIndicator", "Cell", "LayoutArea", "LayoutItem", "Handle", "Stepper", "Tab",
        "TouchBar", "StatusItem"]

    var name: String {
        if rawValue >= XCUIElement.ElementType.names.count {
            return "AnyElement"
        } else {
            return XCUIElement.ElementType.names[Int(rawValue)]
        }
    }

    var queryProvider: String {
        let typeName = name
        if typeName.last == "x" || typeName.last == "h" {
            return typeName.lowercaseFirstLetter + "es"
        } else {
            return typeName.lowercaseFirstLetter + "s"
        }
    }
}
