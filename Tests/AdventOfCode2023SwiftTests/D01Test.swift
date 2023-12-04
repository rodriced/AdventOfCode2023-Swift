@testable import AdventOfCode2023Swift
import XCTest

final class D01Test: XCTestCase, DayValidation {
    let day = D01()
    
    let sample = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """
    
    let sample2 = """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """
    
    func testPuzzle1Sample() {
        XCTAssertEqual(day.puzzle1(Input(.test(sample))), 142)
    }
    
    func testPuzzle1Final() {
        validatePuzzle1(with: 54597)
    }
    
    func testPuzzle2Sample() {
        XCTAssertEqual(day.puzzle2(Input(.test(sample2))), 281)
    }

    func testPuzzle2Final() {
        validatePuzzle2(with: 54504)
    }
}
