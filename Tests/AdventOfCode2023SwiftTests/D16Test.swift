@testable import AdventOfCode2023Swift
import XCTest

final class D16Test: XCTestCase, DayValidation {
    let day = D16()
    
    let sample = #"""
    .|...\....
    |.-.\.....
    .....|-...
    ........|.
    ..........
    .........\
    ..../.\\..
    .-.-/..|..
    .|....-|.\
    ..//.|....
    """#

    func testPuzzle1Sample() {
        XCTAssertEqual(day.puzzle1(Input(.test(sample))), 46)
    }
    
    func testPuzzle1Final() {
        validatePuzzle1(with: 7860)
    }
    
    func testPuzzle2Sample() {
        XCTAssertEqual(day.puzzle2(Input(.test(sample))), 51)
    }

    func testPuzzle2Final() {
        validatePuzzle2(with: 8331)
    }
}
