import SwiftUI


public struct Canvas<Page: View>: View {
    private let _page: Page
    private let width: Double
    private let height: Double

    public init(page: Page, width: Double = 600, height: Double = 400) {
        self._page = page
        self.width = width
        self.height = height
    }

    var page: some View {
        _page
            .frame(width: width, height: height)
            .padding()
    }

    public var body: some View {
        page
    }

    func render(to output: Output, format: String) throws {
        switch output {
            case .file(let url):
                if format == "png" {
                    guard let data = page.renderPNG() else {
                        return
                    }
                    try data.write(to: url)
                    print("Plot saved to \(url.path()).")
                } else {
                    let url = page.render(to: url.path())
                    print("Plot saved to \(url.path()).")
                }
            case .clipboard:
                if format == "png" {
                    let data = page.renderPNG()
                    let pasteboard = NSPasteboard.general
                    pasteboard.clearContents()
                    pasteboard.setData(data, forType: .png)
                    print("Plot saved to clipboard.")
                } else {
                    let data = page.render()
                    let pasteboard = NSPasteboard.general
                    pasteboard.clearContents()
                    pasteboard.setData(data, forType: .pdf)
                    print("Plot saved to clipboard.")
                }
        }
    }
}

