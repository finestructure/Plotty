import ArgumentParser

@main
struct Plotty: AsyncParsableCommand {
    @MainActor
    mutating func run() async throws {
        let data = Measurement.fetchData()
        let page = Page(data: data)
        let canvas = Canvas(page: page)
        let filename = "~/Downloads/chart.pdf"
        canvas.render(to: filename)
    }
}
