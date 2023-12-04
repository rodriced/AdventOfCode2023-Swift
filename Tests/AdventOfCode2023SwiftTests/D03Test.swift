@testable import AdventOfCode2023Swift
import XCTest

final class D03Test: XCTestCase, DayValidation {
    let day = D03()
    
    let sample = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """
    
    func testPuzzle1Sample() {
        XCTAssertEqual(day.puzzle1(Input(.test(sample))), 4361)
    }
    
    func testPuzzle1Final() {
        validatePuzzle1(with: 528799)
    }
    
    func testPuzzle2Sample() {
        XCTAssertEqual(day.puzzle2(Input(.test(sample))), 467835)
    }

    func testPuzzle2Final() {
        validatePuzzle2(with: 84907174)
    }
}
