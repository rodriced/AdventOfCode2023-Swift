@testable import AdventOfCode2023Swift
import XCTest

final class D12Test: XCTestCase, DayValidation {
    let day = D12()
    
    let sample = """
    ???.### 1,1,3
    .??..??...?##. 1,1,3
    ?#?#?#?#?#?#?#? 1,3,1,6
    ????.#...#... 4,1,1
    ????.######..#####. 1,6,5
    ?###???????? 3,2,1
    """
    
    func testPuzzle1Sample() {
        XCTAssertEqual(day.puzzle1(Input(.test(sample))), 21)
    }
    
    func testPuzzle1Final() {
        validatePuzzle1(with: 7633)
    }
    
    func testPuzzle2Sample() {
        XCTAssertEqual(day.puzzle2(Input(.test(sample))), 525152)
    }
    
    func testPuzzle2Final() {
        validatePuzzle2(with: 23903579139437)
    }
}
