import ArgumentParser

@main
struct Plotty: AsyncParsableCommand {
    @Option(name: .shortAndLong, help: "The output format of the canvas.")
    var format: String = "pdf"

    @Option(name: .shortAndLong, help: "The height of the canvas in points.")
    var height: Double = 600

    @Option(name: .shortAndLong, help: "The width of the canvas in points.")
    var width: Double = 600

    @Option(help: "The header of the graph.")
    var header: String?

    @Option(name: .shortAndLong, help: "The path to the input file. Use '-' for stdin and 'clipboard' to read data from the Clipboard.")
    var input: Input = .stdin

    @Option(name: .shortAndLong, help: "The title of the graph.")
    var title: String?

    @Option(name: .shortAndLong, help: "The path to the output file. Use 'clipboard' to copy the output to the Clipboard.")
    var output: Output = .clipboard

    @MainActor
    mutating func run() async throws {
        print("Reading data...")

        var measurements = [Measurement?]()
        for line in input {
            measurements.append(Measurement.parse(line))
        }
        let series = measurements.series
        let data = series.enumerated().map {
            (id: "Series: \($0)", data: $1)
        }

        guard !data.isEmpty else {
            print("No data found.")
            return
        }
        print("Parsed data:")
        print("\(data)")

        let page = Page(data: data, header: header, title: title)
        let canvas = Canvas(page: page, width: width, height: height)
        try canvas.render(to: output, format: format)
    }
}
