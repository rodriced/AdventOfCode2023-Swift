@testable import AdventOfCode2023Swift
import XCTest

import Algorithms

final class D15Test: XCTestCase, DayValidation {
    let day = D15()
    
    let sample = """
    rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
    """

    func testPuzzle1Sample() {
        XCTAssertEqual(day.puzzle1(Input(.test(sample))), 1320)
    }
    
    func testPuzzle1Final() {
        validatePuzzle1(with: 514281)
    }
    
    func testPuzzle2Sample() {
        XCTAssertEqual(day.puzzle2(Input(.test(sample))), 145)
    }

    func testPuzzle2Final() {
        validatePuzzle2(with: 244199)
    }
}
