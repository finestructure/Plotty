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


extension [Measurement?] {
    var series: [[Measurement]] {
        generateSeries(self)
    }
}


func generateSeries<T>(_ sequence: any Sequence<T?>) -> [[T]] {
    var series = [[T]]()
    var values = [T]()
    for value in sequence {
        if let value {
            values.append(value)
        } else {
            series.append(values)
            values = []
        }
    }
    series.append(values)
    return series.filter{ !$0.isEmpty }
}
