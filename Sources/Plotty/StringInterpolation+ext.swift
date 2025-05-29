extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: [(id: String, data: [Measurement])]) {
        var res = ""
        var first = true
        for (id, data) in value {
            defer { first = false }
            if !first { res += "\n" }
            res += "\(id)"
            for d in data {
                res += String(format: " %8.3f", d.value)
            }
        }
        appendInterpolation(res)
    }
}
