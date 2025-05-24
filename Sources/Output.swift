import Foundation

import ArgumentParser


enum Output: Equatable, ExpressibleByArgument {
    case file(URL)
    case clipboard

    init?(argument: String) {
        switch argument {
            case "-":
                self = .clipboard
            default:
                let url = URL(fileURLWithPath: argument.expandingTildeInPath)
                self = .file(url)
        }
    }
}
