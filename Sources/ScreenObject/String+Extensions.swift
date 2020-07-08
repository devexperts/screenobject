/*
 ScreenObject

 Copyright (c) 2020 Devexperts LLC

 See https://code.devexperts.com for more open source projects
*/

import Foundation

extension String {
    var normalised: String {
        let symbolDescriptions = [("#", " Hash "),
                                  ("$", " Dollar "),
                                  ("%", " Percent "),
                                  ("&", " And "),
                                  ("+", " Plus "),
                                  ("-", " Minus "),
                                  (".", " Dot "),
                                  ("/", " Slash "),
                                  ("@", " At "),
                                  ("_", " "),
                                  ("\n", " ")]
        var normalised = self
        for (symbol, description) in symbolDescriptions {
            normalised = normalised.replacingOccurrences(of: symbol, with: description)
        }
        normalised = normalised.filter { $0.isLetter || $0.isNumber || $0.isWhitespace}
        return normalised
    }

    var lowercaseFirstLetter: String {
        if let first = first {
            return first.lowercased() + dropFirst()
        } else {
            return self
        }
    }

    var isAllCapitals: Bool {
        for character in self where character.isLowercase {
            return false
        }
        return true
    }

    var upperCamelCase: String {
        let words = normalised.components(separatedBy: CharacterSet.whitespaces)
        var capitalized = words.reduce("") {
            if let first = $1.first {
                if $1.isAllCapitals {
                    return $0 + first.uppercased() + $1.dropFirst().lowercased()
                } else {
                    return $0 + first.uppercased() + $1.dropFirst()
                }
            } else {
                return $0
            }
        }
        if let first = capitalized.first {
            if !first.isLetter {
                capitalized = "The" + capitalized
            }
        }
        return capitalized
    }

    var lowerCamelCase: String {
        return upperCamelCase.lowercaseFirstLetter
    }

    var oneLine: String {
        replacingOccurrences(of: "\n", with: "\\n")
    }

    var placeholder: String {
        return "<#" + self + "#" + ">"
    }
}
