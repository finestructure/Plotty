import ArgumentParser

@main
struct Plotty: AsyncParsableCommand {
    @MainActor
    mutating func run() async throws {
        print("Reading data...")

        var data = [Measurement]()
        while let line = readLine() {
            print(line)
            if let m = Measurement.parse(line) {
                data.append(m)
            }
        }
        print("Data:")
        print(data)

        let page = Page(data: data)
        let canvas = Canvas(page: page)
        let filename = "~/Downloads/chart.pdf"
        canvas.render(to: filename)
    }
}
