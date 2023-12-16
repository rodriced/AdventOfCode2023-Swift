@testable import AdventOfCode2023Swift
import XCTest

final class D14Test: XCTestCase, DayValidation {
    let day = D14()
    
    let sample = """
    O....#....
    O.OO#....#
    .....##...
    OO.#O....O
    .O.....O#.
    O.#..O.#.#
    ..O..#O..O
    .......O..
    #....###..
    #OO..#....
    """

    func testPuzzle1Sample() {
        XCTAssertEqual(day.puzzle1(Input(.test(sample))), 136)
    }
    
    func testPuzzle1Final() {
        validatePuzzle1(with: 107951)
    }
    
    func testPuzzle2Sample() {
        XCTAssertEqual(day.puzzle2(Input(.test(sample))), 64)
    }

    func testPuzzle2Final() {
        validatePuzzle2(with: 95736)
    }
}
