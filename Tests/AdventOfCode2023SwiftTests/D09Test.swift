@testable import AdventOfCode2023Swift
import XCTest

final class D09Test: XCTestCase, DayValidation {
    let day = D09()
    
    let sample = """
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
    """
    
    func testPuzzle1Sample() {
        XCTAssertEqual(day.puzzle1(Input(.test(sample))), 114)
    }
    
    func testPuzzle1Final() {
        validatePuzzle1(with: 1731106378)
    }
    
    func testPuzzle2Sample() {
        XCTAssertEqual(day.puzzle2(Input(.test(sample))), 2)
    }

    func testPuzzle2Final() {
        validatePuzzle2(with: 1087)
    }
}
