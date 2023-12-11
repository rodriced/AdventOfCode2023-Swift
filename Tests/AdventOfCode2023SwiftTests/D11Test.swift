@testable import AdventOfCode2023Swift
import XCTest

final class D11Test: XCTestCase, DayValidation {
    let day = D11()
    
    let sample = """
    ...#......
    .......#..
    #.........
    ..........
    ......#...
    .#........
    .........#
    ..........
    .......#..
    #...#.....
    """
    
    func testPuzzle1Sample() {        
        XCTAssertEqual(day.puzzle1(Input(.test(sample))), 374)
    }
    
    func testPuzzle1Final() {
        validatePuzzle1(with: 9795148)
    }
    
   func testPuzzle2Final() {
        validatePuzzle2(with: 650672493820)
    }
}
