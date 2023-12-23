@testable import AdventOfCode2023Swift
import XCTest

final class D18Test: XCTestCase, DayValidation {
    let day = D18()

    let sample = """
    R 6 (#70c710)
    D 5 (#0dc571)
    L 2 (#5713f0)
    D 2 (#d2c081)
    R 2 (#59c680)
    D 2 (#411b91)
    L 5 (#8ceee2)
    U 2 (#caa173)
    L 1 (#1b58a2)
    U 2 (#caa171)
    R 2 (#7807d2)
    U 3 (#a77fa3)
    L 2 (#015232)
    U 2 (#7a21e3)
    """

    let sample2 = """
    R 6 (#70c710)
    U 6 (#70c710)
    R 1 (#70c710)
    D 7 (#70c710)
    L 1 (#70c710)
    D 4 (#0dc571)
    L 2 (#5713f0)
    D 2 (#d2c081)
    R 2 (#59c680)
    D 2 (#411b91)
    L 5 (#8ceee2)
    U 2 (#caa173)
    L 1 (#1b58a2)
    U 2 (#caa171)
    R 2 (#7807d2)
    U 3 (#a77fa3)
    L 2 (#015232)
    U 2 (#7a21e3)
    """

    func testPuzzle1Sample() {
        XCTAssertEqual(day.puzzle1(Input(.test(sample))), 62)
    }
    
    func testPuzzle1Sample2() {
        XCTAssertEqual(day.puzzle1(Input(.test(sample2))), 76)
    }
    
    func testPuzzle1Final() {
        validatePuzzle1(with: 40761)
    }
    
    func testPuzzle2Sample() {
        XCTAssertEqual(day.puzzle2(Input(.test(sample))), 952408144115)
    }

    func testPuzzle2Final() {
        validatePuzzle2(with: 106920098354636)
    }
}
