import SwiftUI

import Charts


struct PerformanceChart: View {
    let data: [(id: String, data: [Measurement])]
    let yAxisDomain: YAxisDomain?

    var body: some View {
        if let yAxisDomain {
            chart.chartYScale(domain: yAxisDomain)
        } else {
            chart
        }
    }

    var chart: some View {
        Chart(data, id: \.id) { series in
            ForEach(Array(series.data.enumerated()), id: \.0) { data in
                PointMark(
                    x: .value("Index", data.0),
                    y: .value("Value", data.1.value)
                )
            }
            .foregroundStyle(by: .value("series", series.id))
        }
    }
}


typealias YAxisDomain = ClosedRange<Double>


extension YAxisDomain {
    init?(_ values: [Double]) {
        guard values.count == 2 else { return nil }
        self = values[0]...values[1]
    }
}
