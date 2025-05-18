import SwiftUI


struct Page: View {
    let data: [(id: String, data: [Measurement])]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Plotty")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text("Performance comparison")
                .font(.title.bold())

            PerformanceChart(data: data)
        }
    }
}
