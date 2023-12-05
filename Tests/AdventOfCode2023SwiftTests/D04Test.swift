@testable import AdventOfCode2023Swift
import XCTest

final class D04Test: XCTestCase, DayValidation {
    let day = D04()
    
    let sample = """
    Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
    Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
    Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
    Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
    Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
    Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
    """
    
    func testPuzzle1Sample() {
        XCTAssertEqual(day.puzzle1(Input(.test(sample))), 13)
    }
    
    func testPuzzle1Final() {
        validatePuzzle1(with: 25571)
    }
    
    func testPuzzle2Sample() {
        XCTAssertEqual(day.puzzle2(Input(.test(sample))), 30)
    }

    func testPuzzle2Final() {
        validatePuzzle2(with: 8805731)
    }
}
