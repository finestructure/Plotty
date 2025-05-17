import SwiftUI

import Charts


struct PerformanceChart: View {
    let data: [Measurement]

    var body: some View {
        Chart(data, id: \.index) {
            PointMark(
                x: .value("Index", $0.index),
                y: .value("Ratio", $0.ratio)
            )
        }
        .chartYAxisLabel("Timing", position: .trailing, alignment: .center)
    }
}
