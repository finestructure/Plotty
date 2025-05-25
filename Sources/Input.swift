import Cocoa
import Foundation

import ArgumentParser


enum Input: ExpressibleByArgument {
    case clipboard
    case file(URL)
    case stdin

    init?(argument: String) {
        switch argument {
            case "clipboard":
                self = .clipboard
            case "-":
                self = .stdin
            default:
                let url = URL(fileURLWithPath: argument.expandingTildeInPath)
                self = .file(url)
        }
    }
}


struct InputIterator: IteratorProtocol {
    enum Cursor {
        case stdin
        case lines(next: String?, remainder: Array<String>.SubSequence)
        case none

        init(_ string: String) {
            let lines = string.components(separatedBy: .newlines)
            let next = lines.first
            let remainder = lines.dropFirst()
            self = .lines(next: next, remainder: remainder)
        }
    }

    var cursor: Cursor

    init(_ input: Input) {
        switch input {
            case .clipboard:
                if let content = NSPasteboard.general.string(forType: .string) {
                    cursor = .init(content)
                } else {
                    cursor = .none
                }

            case .file(let url):
                if let content = try? String(contentsOf: url, encoding: .utf8) {
                    cursor = .init(content)
                } else {
                    cursor = .none
                }

            case .stdin:
                cursor = .stdin
        }
    }

    mutating func next() -> String? {
        switch cursor {
            case .none:
                return nil
            case .stdin:
                return readLine()
            case let .lines(next: next, remainder: remainder):
                cursor = .lines(next: remainder.first, remainder: remainder.dropFirst())
                return next
        }
    }
}


extension Input: Sequence {
    func makeIterator() -> InputIterator {
        .init(self)
    }
}
