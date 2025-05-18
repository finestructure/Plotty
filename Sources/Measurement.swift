import RegexBuilder

struct Measurement {
    var value: Double
}


extension Measurement {
    static func parse(_ input: String) -> Self? {
        let regex = /(.*\s|^)([0-9]+[.][0-9]+)(\s.*|$)/

        if let match = input.wholeMatch(of: regex),
           let res = Double(match.output.2) {
            return .init(value: res)
        } else {
            return nil
        }
    }
}
