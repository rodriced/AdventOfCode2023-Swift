@testable import AdventOfCode2023Swift
import XCTest

final class D20Test: XCTestCase, DayValidation {
    let day = D20()

    let sample1 = """
    broadcaster -> a, b, c
    %a -> b
    %b -> c
    %c -> inv
    &inv -> a
    """

    let sample2 = """
    broadcaster -> a
    %a -> inv, con
    &inv -> b
    %b -> con
    &con -> output
    """

    func testPuzzle1Sample() {
        XCTAssertEqual(day.puzzle1(Input(.test(sample1))), 32000000)
    }
    
    func testPuzzle1Sample2() {
        XCTAssertEqual(day.puzzle1(Input(.test(sample2))), 11687500)
    }
    
    func testPuzzle1Final() {
        validatePuzzle1(with: 794930686)
    }

    func testPuzzle2Final() {
        validatePuzzle2(with: 244465191362269)
    }
}
