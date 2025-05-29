import ArgumentParser

@main
struct Plotty: AsyncParsableCommand {
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

    @Option(name: .shortAndLong, parsing: .upToNextOption, help: "Y axis range: ymin ymax. The range is determined automatically if unspecified.")
    var yAxisRange: [Double] = []

    var yAxisDomain: YAxisDomain? { .init(yAxisRange) }

    @MainActor
    mutating func run() async throws {
        print("Reading data...")

        var rows = [Row?]()
        for line in input {
            rows.append(Row.parse(line))
        }
        let data = rows.series

        guard !data.isEmpty else {
            print("No data found.")
            return
        }
        print("Parsed data:")
        print("\(data)")

        let page = Page(data: data, header: header, title: title, yAxisDomain: yAxisDomain)
        let canvas = Canvas(page: page, width: width, height: height)
        canvas.render(to: output)
    }
}
