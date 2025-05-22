import Foundation

import ArgumentParser


enum Input: ExpressibleByArgument {
    case file(URL)
    case stdin

    init?(argument: String) {
        switch argument {
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
    }

    var cursor: Cursor

    init(_ input: Input) {
        switch input {
            case .file(let url):
                if let content = try? String(contentsOf: url, encoding: .utf8) {
                    let lines = content.components(separatedBy: .newlines)
                    let next = lines.first
                    let remainder = lines.dropFirst()
                    cursor = .lines(next: next, remainder: remainder)
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
