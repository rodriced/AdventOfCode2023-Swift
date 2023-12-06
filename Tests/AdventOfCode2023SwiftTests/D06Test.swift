@testable import AdventOfCode2023Swift
import XCTest

final class D06Test: XCTestCase, DayValidation {
    let day = D06()
    
    let sample = """
    Time:      7  15   30
    Distance:  9  40  200
    """
    
    func testPuzzle1Sample() {
        XCTAssertEqual(day.puzzle1(Input(.test(sample))), 288)
    }
    
    func testPuzzle1Final() {
        validatePuzzle1(with: 32076)
    }
    
    func testPuzzle2Sample() {
        XCTAssertEqual(day.puzzle2(Input(.test(sample))), 71503)
    }

    func testPuzzle2Final() {
        validatePuzzle2(with: 34278221)
    }
}
