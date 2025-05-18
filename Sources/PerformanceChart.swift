import SwiftUI

import Charts


struct PerformanceChart: View {
    let data: [(id: String, data: [Measurement])]

    var body: some View {
        Chart(data, id: \.id) { series in
            ForEach(Array(series.data.enumerated()), id: \.0) { data in
                PointMark(
                    x: .value("Index", data.0),
                    y: .value("Value", data.1.value)
                )
            }
            .foregroundStyle(by: .value("series", series.id))
        }
        //        .chartYAxisLabel("Timing", position: .trailing, alignment: .center)
    }
}
