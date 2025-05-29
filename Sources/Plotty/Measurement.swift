import RegexBuilder


enum Row {
    case measurement(Measurement)
    case seriesName(String)

    var measurement: Measurement? {
        switch self {
            case let .measurement(m):
                return m
            case .seriesName:
                return nil
        }
    }

    var seriesName: String? {
        switch self {
            case .measurement:
                return nil
            case let .seriesName(name):
                return name
        }
    }
}

struct Measurement: Equatable {
    var value: Double
}


extension Row {
    static func parse(_ input: String) -> Self? {
        // https://swiftregex.com
        let valueRegex = /(.*\s|^)([0-9]+[.][0-9]+)(\s.*|$)/
        let seriesNameRegex = /^Series:\s*(.*)\s*$/

        if let match = input.wholeMatch(of: seriesNameRegex) {
            return .seriesName(String(match.output.1).trimmingCharacters(in: .whitespaces))
        } else if let match = input.wholeMatch(of: valueRegex),
                  let res = Double(match.output.2) {
            return .measurement(.init(value: res))
        } else {
            return nil
        }
    }
}


struct Series: Equatable {
    var id: String
    var data: [Measurement]
}

extension [Row?] {

    static func parse(_ input: Input) -> Self {
        var rows = [Row?]()
        for line in input {
            rows.append(Row.parse(line))
        }
        return rows
    }

    var series: [Series] {
        var res: [Series] = []
        var current: Series? = nil
        for row in self {
            switch row {
                case .measurement(let measurement):
                    if current == nil {
                        // There's a break in the sequence, start a new series
                        current = .init(id: "Series \(res.count)", data: [])
                    }
                    current?.data.append(measurement)
                case .seriesName(let id):
                    if let current, !current.data.isEmpty {
                        // Flush any open, non-empty series to the result
                        res.append(.init(id: current.id, data: current.data))
                    }
                    current = .init(id: id, data: [])
                case nil:
                    if current == nil {
                        // Ignore subsequent breaks in the sequence
                        continue
                    }
                    if let current, !current.data.isEmpty {
                        // Flush any open, non-empty series to the result
                        res.append(.init(id: current.id, data: current.data))
                    }
                    current = .init(id: "Series \(res.count)", data: [])
            }
        }
        // Flush any open series to the result
        if let current {
            res.append(.init(id: current.id, data: current.data))
        }
        return res
    }
}


// Generate nested sequences [T] from a sequence of T?, where each nil entry starts a new Array.
func _generateSeries<T>(_ sequence: any Sequence<T?>) -> [[T]] {
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
