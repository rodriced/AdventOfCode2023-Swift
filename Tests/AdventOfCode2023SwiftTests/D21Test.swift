@testable import AdventOfCode2023Swift
import XCTest

final class D21Test: XCTestCase, DayValidation {
    let day = D21()

    let sample = """
    ...........
    .....###.#.
    .###.##..#.
    ..#.#...#..
    ....#.#....
    .##..S####.
    .##..#...#.
    .......##..
    .##.#.####.
    .##..##.##.
    ...........
    """

    func testPuzzle1Sample() {
        let day = D21()
        day.maxSteps = 6
        XCTAssertEqual(day.puzzle1(Input(.test(sample))), 16)
    }
    
    func testPuzzle1Final() {
        let day = D21()
        day.maxSteps = 64
        XCTAssertEqual(day.puzzle1(Input(.prod(day.num))), 3578)
        validatePuzzle1(with: 3578)
    }
    
    func testPuzzle2Sample() {
        XCTAssertEqual(day.puzzle2(Input(.test(sample))), 0)
    }
    
    func testPuzzle2Final() {
        validatePuzzle2(with: 0)
    }
}
