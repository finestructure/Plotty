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

    func render(to filename: String) {
        page.render(to: filename)
    }
}

