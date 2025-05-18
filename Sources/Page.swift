import SwiftUI


struct Page: View {
    let data: [(id: String, data: [Measurement])]
    let header: String?
    let title: String?

    var body: some View {
        VStack(alignment: .leading) {
            if let header {
                Text(header)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            if let title {
                Text(title)
                    .font(.title.bold())
            }

            PerformanceChart(data: data)
        }
    }
}
