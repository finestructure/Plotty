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

    func render(to output: Output) {
        switch output {
            case .file(let url):
                let url = page.render(to: url.path())
                print("Plot saved to \(url.path()).")
            case .clipboard:
                let data = page.render()
                let pasteboard = NSPasteboard.general
                pasteboard.clearContents()
                pasteboard.setData(data, forType: .pdf)
                print("Plot saved to clipboard.")
        }
    }
}

