import SwiftUI


struct Page: View {
    let data: [Measurement]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Performance comparison")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text("Your metric here")
                .font(.title.bold())

            PerformanceChart(data: data)
        }
    }
}
