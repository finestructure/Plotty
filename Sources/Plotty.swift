import ArgumentParser

@main
struct Plotty: AsyncParsableCommand {
    @Option(name: .shortAndLong, help: "The height of the canvas in points.")
    var height: Double = 600

    @Option(name: .shortAndLong, help: "The width of the canvas in points.")
    var width: Double = 600

    @Option(help: "The header of the graph.")
    var header: String?

    @Option(name: .shortAndLong, help: "The title of the graph.")
    var title: String?

    @MainActor
    mutating func run() async throws {
        print("Reading data...")

        var measurements = [Measurement?]()
        while let line = readLine() {
            print(line)
            measurements.append(Measurement.parse(line))
        }
        let series = measurements.series
        let data = series.enumerated().map {
            (id: "Series: \($0)", data: $1)
        }
        print("Data:")
        print(data)

        let page = Page(data: data, header: header, title: title)
        let canvas = Canvas(page: page, width: width, height: height)
        let filename = "~/Downloads/chart.pdf"
        canvas.render(to: filename)
    }
}
