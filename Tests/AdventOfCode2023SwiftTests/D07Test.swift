@testable import AdventOfCode2023Swift
import XCTest

final class D07Test: XCTestCase, DayValidation {
    let day = D07()
    
    let sample = """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
    """
    
    func testPuzzle1Sample() {
        XCTAssertEqual(day.puzzle1(Input(.test(sample))), 6440)
    }
    
    func testPuzzle1Final() {
        validatePuzzle1(with: 250370104)
    }
    
    func testPuzzle2Sample() {
        XCTAssertEqual(day.puzzle2(Input(.test(sample))), 5905)
    }

    func testPuzzle2Final() {
        validatePuzzle2(with: 251735672)
    }
}
