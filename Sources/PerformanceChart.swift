import SwiftUI

import Charts


struct PerformanceChart: View {
    let data: [Measurement]

    var body: some View {
        Chart(Array(data.enumerated()), id: \.0) {
            PointMark(
                x: .value("Index", $0.0),
                y: .value("Ratio", $0.1.value)
            )
        }
        .chartYAxisLabel("Timing", position: .trailing, alignment: .center)
    }
}
