@testable import AdventOfCode2023Swift
import XCTest

final class D08Test: XCTestCase, DayValidation {
    let day = D08()
    
    let sample1a = """
    RL

    AAA = (BBB, CCC)
    BBB = (DDD, EEE)
    CCC = (ZZZ, GGG)
    DDD = (DDD, DDD)
    EEE = (EEE, EEE)
    GGG = (GGG, GGG)
    ZZZ = (ZZZ, ZZZ)
    """
    
    let sample1b = """
    LLR

    AAA = (BBB, BBB)
    BBB = (AAA, ZZZ)
    ZZZ = (ZZZ, ZZZ)
    """
    
    let sample2 = """
    LR

    11A = (11B, XXX)
    11B = (XXX, 11Z)
    11Z = (11B, XXX)
    22A = (22B, XXX)
    22B = (22C, 22C)
    22C = (22Z, 22Z)
    22Z = (22B, 22B)
    XXX = (XXX, XXX)
    """
    
    func testPuzzle1SampleA() {
        XCTAssertEqual(day.puzzle1(Input(.test(sample1a))), 2)
    }
    
    func testPuzzle1SampleB() {
        XCTAssertEqual(day.puzzle1(Input(.test(sample1b))), 6)
    }
    
    func testPuzzle1Final() {
        validatePuzzle1(with: 22199)
    }
    
    func testPuzzle2Sample() {
        XCTAssertEqual(day.puzzle2(Input(.test(sample2))), 6)
    }

    func testPuzzle2Final() {
        validatePuzzle2(with: 13334102464297)
    }
}
