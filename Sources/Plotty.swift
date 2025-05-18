import ArgumentParser

@main
struct Plotty: AsyncParsableCommand {
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

        let page = Page(data: data)
        let canvas = Canvas(page: page)
        let filename = "~/Downloads/chart.pdf"
        canvas.render(to: filename)
    }
}
