@testable import Plotty

import Testing


struct PlottyTests {

    @Test("Measurement.parse")
    func Measurement_parse() async throws {
        #expect(Measurement.parse("1.0")?.value == 1.0)
        #expect(Measurement.parse("a 1.0")?.value == 1.0)
        #expect(Measurement.parse("a b 1.0")?.value == 1.0)
        #expect(Measurement.parse("1.0 a")?.value == 1.0)
        #expect(Measurement.parse("1.0 a b")?.value == 1.0)
        #expect(Measurement.parse("a 1.0 b")?.value == 1.0)
        #expect(Measurement.parse("a b 1.0 a b")?.value == 1.0)
        #expect(Measurement.parse("1")?.value == nil)
        #expect(Measurement.parse("a")?.value == nil)
    }

    @Test
    func generateSeries() async throws {
        #expect(_generateSeries([1]) == [[1]])
        #expect(_generateSeries([1, nil]) == [[1]])
        #expect(_generateSeries([1, 2, nil, 3]) == [[1, 2], [3]])
        #expect(_generateSeries([nil, 1, 2, nil, 3]) == [[1, 2], [3]])
    }

}
