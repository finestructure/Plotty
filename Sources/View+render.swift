import SwiftUI


extension View {
    // https://www.hackingwithswift.com/quick-start/swiftui/how-to-render-a-swiftui-view-to-a-pdf
    @discardableResult
    @MainActor
    public func render(to filename: String, locale: String = "en") -> URL {
        let renderer = ImageRenderer(content: self.environment(\.locale, .init(identifier: locale)))

        let url = URL(fileURLWithPath: filename.expandingTildeInPath)

        renderer.render { size, context in
            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)

            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                return
            }

            pdf.beginPDFPage(nil)
            context(pdf)
            pdf.endPDFPage()
            pdf.closePDF()
        }

        return url
    }

    @MainActor
    public func render(locale: String = "en") -> Data {
        let renderer = ImageRenderer(content: self.environment(\.locale, .init(identifier: locale)))

        let data = NSMutableData()

        renderer.render { size, context in
            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)

            guard let consumer = CGDataConsumer(data: data),
                  let pdf = CGContext(consumer: consumer, mediaBox: &box, nil) else {
                print("Failed to create graphics context.")
                return
            }

            pdf.beginPDFPage(nil)
            context(pdf)
            pdf.endPDFPage()
            pdf.closePDF()
        }

        return data as Data
    }
}
