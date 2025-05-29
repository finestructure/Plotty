@testable import Plotty

import Testing


struct PlottyTests {

    @Test("Measurement.parse")
    func Measurement_parse() async throws {
        #expect(Row.parse("1.0")?.measurement?.value == 1.0)
        #expect(Row.parse("a 1.0")?.measurement?.value == 1.0)
        #expect(Row.parse("a b 1.0")?.measurement?.value == 1.0)
        #expect(Row.parse("1.0 a")?.measurement?.value == 1.0)
        #expect(Row.parse("1.0 a b")?.measurement?.value == 1.0)
        #expect(Row.parse("a 1.0 b")?.measurement?.value == 1.0)
        #expect(Row.parse("a b 1.0 a b")?.measurement?.value == 1.0)
        #expect(Row.parse("1") == nil)
        #expect(Row.parse("a") == nil)
        #expect(Row.parse("Series: foo")?.seriesName == "foo")
        #expect(Row.parse("Series:foo")?.seriesName == "foo")
        #expect(Row.parse("Series:foo ")?.seriesName == "foo")
        #expect(Row.parse("Series: foo123 ")?.seriesName == "foo123")
        #expect(Row.parse("Series: foo 123 ")?.seriesName == "foo 123")
    }

    @Test
    func generateSeries() async throws {
        #expect(_generateSeries([1]) == [[1]])
        #expect(_generateSeries([1, nil]) == [[1]])
        #expect(_generateSeries([1, 2, nil, 3]) == [[1, 2], [3]])
        #expect(_generateSeries([nil, 1, 2, nil, 3]) == [[1, 2], [3]])
    }

    @Test
    func Row_series_0() async throws {
        let input = Input.string("""
            Suite AllTests passed after 5.081 seconds
            Suite AllTests passed after 5.274 seconds

            Suite AllTests passed after 4.729 seconds
            Suite AllTests passed after 4.755 seconds
            """)
        let rows = [Row?].parse(input)
        let series = rows.series
        #expect(series.count == 2)
        #expect(series.first ==  .init(id: "Series 0",
                                       data: [
                                        .init(value: 5.081),
                                        .init(value: 5.274),
                                       ])
        )
        #expect(series.last == .init(id: "Series 1",
                                     data: [
                                        .init(value: 4.729),
                                        .init(value: 4.755),
                                     ])
        )
    }

    @Test
    func Row_series_1() async throws {
        let input = Input.string("""
            Series: Default Strategy
            Suite AllTests passed after 5.081 seconds
            Suite AllTests passed after 5.274 seconds
            Series: file_copy Strategy
            Suite AllTests passed after 4.729 seconds
            Suite AllTests passed after 4.755 seconds
            """)
        let rows = [Row?].parse(input)
        let series = rows.series
        #expect(series.count == 2)
        #expect(series.first ==  .init(id: "Default Strategy",
                                       data: [
                                        .init(value: 5.081),
                                        .init(value: 5.274),
                                       ])
        )
        #expect(series.last == .init(id: "file_copy Strategy",
                                     data: [
                                        .init(value: 4.729),
                                        .init(value: 4.755),
                                     ])
        )
    }

    @Test
    func Row_series_2() async throws {
        let input = Input.string("""
            Series: Default Strategy
            
            Suite AllTests passed after 5.081 seconds
            Suite AllTests passed after 5.274 seconds
            Series: file_copy Strategy
            Suite AllTests passed after 4.729 seconds
            Suite AllTests passed after 4.755 seconds
            """)
        let rows = [Row?].parse(input)
        let series = rows.series
        #expect(series.count == 2)
        #expect(series.first ==  .init(id: "Series 0",
                                       data: [
                                        .init(value: 5.081),
                                        .init(value: 5.274),
                                       ])
        )
        #expect(series.last == .init(id: "file_copy Strategy",
                                     data: [
                                        .init(value: 4.729),
                                        .init(value: 4.755),
                                     ])
        )
    }

    @Test
    func Row_series_3() async throws {
        let input = Input.string("""
            Series: Default Strategy
            Suite AllTests passed after 5.081 seconds
            Suite AllTests passed after 5.274 seconds
            
            Series: file_copy Strategy
            Suite AllTests passed after 4.729 seconds
            Suite AllTests passed after 4.755 seconds
            """)
        let rows = [Row?].parse(input)
        let series = rows.series
        #expect(series.count == 2)
        #expect(series.first ==  .init(id: "Default Strategy",
                                       data: [
                                        .init(value: 5.081),
                                        .init(value: 5.274),
                                       ])
        )
        #expect(series.last == .init(id: "file_copy Strategy",
                                     data: [
                                        .init(value: 4.729),
                                        .init(value: 4.755),
                                     ])
        )
    }

    @Test
    func Row_series_4() async throws {
        let input = Input.string("""
            
            Suite AllTests passed after 5.081 seconds
            Suite AllTests passed after 5.274 seconds

            Suite AllTests passed after 4.729 seconds
            Suite AllTests passed after 4.755 seconds
            """)
        let rows = [Row?].parse(input)
        let series = rows.series
        #expect(series.count == 2)
        #expect(series.first ==  .init(id: "Series 0",
                                       data: [
                                        .init(value: 5.081),
                                        .init(value: 5.274),
                                       ])
        )
        #expect(series.last == .init(id: "Series 1",
                                     data: [
                                        .init(value: 4.729),
                                        .init(value: 4.755),
                                     ])
        )
    }

    @Test
    func Row_series_5() async throws {
        let input = Input.string("""
            
            Series: Default Strategy
            Suite AllTests passed after 5.081 seconds
            Suite AllTests passed after 5.274 seconds

            Suite AllTests passed after 4.729 seconds
            Suite AllTests passed after 4.755 seconds
            """)
        let rows = [Row?].parse(input)
        let series = rows.series
        #expect(series.count == 2)
        #expect(series.first ==  .init(id: "Default Strategy",
                                       data: [
                                        .init(value: 5.081),
                                        .init(value: 5.274),
                                       ])
        )
        #expect(series.last == .init(id: "Series 1",
                                     data: [
                                        .init(value: 4.729),
                                        .init(value: 4.755),
                                     ])
        )
    }

    @Test
    func Row_series_6() async throws {
        let input = Input.string("""
            Series: Default Strategy
            Suite AllTests passed after 5.081 seconds
            Suite AllTests passed after 5.274 seconds
            Series: file_copy Strategy
            Suite AllTests passed after 4.729 seconds
            Suite AllTests passed after 4.755 seconds

            """)
        let rows = [Row?].parse(input)
        let series = rows.series
        #expect(series.count == 2)
        #expect(series.first ==  .init(id: "Default Strategy",
                                       data: [
                                        .init(value: 5.081),
                                        .init(value: 5.274),
                                       ])
        )
        #expect(series.last == .init(id: "file_copy Strategy",
                                     data: [
                                        .init(value: 4.729),
                                        .init(value: 4.755),
                                     ])
        )
    }

}
