@testable import AdventOfCode2023Swift
import XCTest

import Algorithms

final class D17Test: XCTestCase, DayValidation {
    let day = D17()

    let sample = """
    2413432311323
    3215453535623
    3255245654254
    3446585845452
    4546657867536
    1438598798454
    4457876987766
    3637877979653
    4654967986887
    4564679986453
    1224686865563
    2546548887735
    4322674655533
    """

    let sample1 = """
    2413
    3211
    3251
    3446
    """

    let sample2 = """
    2411
    3231
    3251
    3446
    """

    let sample3 = """
    0111
    4131
    2181
    1111
    """

    let sample4 = """
    111111111111
    999999999991
    999999999991
    999999999991
    999999999991
    """

    func testPuzzle1Sample() {
        XCTAssertEqual(day.puzzle1(Input(.test(sample))), 102)
    }
    
    func testPuzzle1Final() {
        validatePuzzle1(with: 1008)
    }
    
    func testPuzzle2Sample() {
        XCTAssertEqual(day.puzzle2(Input(.test(sample))), 94)
    }

    func testPuzzle2Sample2() {
        XCTAssertEqual(day.puzzle2(Input(.test(sample4))), 71)
    }

    func testPuzzle2Final() {
        validatePuzzle2(with: 1210)
    }
}
