@testable import AdventOfCode2023Swift
import XCTest

protocol DayValidation {
    associatedtype D: Day

    var day: D { get }

    func validatePuzzle1(with answer: Int)
    func validatePuzzle2(with answer: Int)
}

extension DayValidation {
    func validatePuzzle1(with answer: Int) {
        XCTAssertEqual(day.puzzle1(Input(.prod(day.num))), answer)
    }

    func validatePuzzle2(with answer: Int) {
        XCTAssertEqual(day.puzzle2(Input(.prod(day.num))), answer)
    }
}
