@testable import AdventOfCode2023Swift
import XCTest

final class D13Test: XCTestCase, DayValidation {
    let day = D13()
    
    let sample = """
    #.##..##.
    ..#.##.#.
    ##......#
    ##......#
    ..#.##.#.
    ..##..##.
    #.#.##.#.

    #...##..#
    #....#..#
    ..##..###
    #####.##.
    #####.##.
    ..##..###
    #....#..#
    """
    
    let sample2 = """
    ##...##
    ##...##
    ##.##..
    .##.##.
    .###.##
    #####..
    ...####
    #.#.###
    .###...
    #...###
    #.##.##
    """
    
    func testPuzzle1Sample() {
        XCTAssertEqual(day.puzzle1(Input(.test(sample))), 405)
    }
    
    func testPuzzle1Final() {
        validatePuzzle1(with: 28651)
    }
    
    func testPuzzle2Sample() {
        XCTAssertEqual(day.puzzle2(Input(.test(sample))), 400)
    }

    func testPuzzle2Final() {
        validatePuzzle2(with: 25450)
    }
}
