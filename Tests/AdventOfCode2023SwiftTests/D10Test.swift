@testable import AdventOfCode2023Swift
import XCTest

final class D10Test: XCTestCase, DayValidation {
    let day = D10()
    
    let sample1a = """
    .....
    .S-7.
    .|.|.
    .L-J.
    .....
    """
    
    let sample1b = """
    ..F7.
    .FJ|.
    SJ.L7
    |F--J
    LJ...
    """
    
    let sample2a = """
    ...........
    .S-------7.
    .|F-----7|.
    .||.....||.
    .||.....||.
    .|L-7.F-J|.
    .|..|.|..|.
    .L--J.L--J.
    ...........
    """
    
    let sample2b = """
    .F----7F7F7F7F-7....
    .|F--7||||||||FJ....
    .||.FJ||||||||L7....
    FJL7L7LJLJ||LJ.L-7..
    L--J.L7...LJS7F-7L7.
    ....F-J..F7FJ|L7L7L7
    ....L7.F7||L7|.L7L7|
    .....|FJLJ|FJ|F7|.LJ
    ....FJL-7.||.||||...
    ....L---J.LJ.LJLJ...
    """
    
    let sample2c = """
    FF7FSF7F7F7F7F7F---7
    L|LJ||||||||||||F--J
    FL-7LJLJ||||||LJL-77
    F--JF--7||LJLJ7F7FJ-
    L---JF-JLJ.||-FJLJJ7
    |F|F-JF---7F7-L7L|7|
    |FFJF7L7F-JF7|JL---7
    7-L-JL7||F7|L7F-7F7|
    L.L7LFJ|||||FJL7||LJ
    L7JLJL-JLJLJL--JLJ.L
    """
    
    func testPuzzle1SampleA() {
        XCTAssertEqual(day.puzzle1(Input(.test(sample1a))), 4)
    }
    
    func testPuzzle1SampleB() {
        XCTAssertEqual(day.puzzle1(Input(.test(sample1b))), 8)
    }
    
    func testPuzzle1Final() {
        validatePuzzle1(with: 7066)
    }
    
    func testPuzzle2SampleA() {
        XCTAssertEqual(day.puzzle2(Input(.test(sample2a))), 4)
    }

    func testPuzzle2SampleB() {
        XCTAssertEqual(day.puzzle2(Input(.test(sample2b))), 8)
    }

    func testPuzzle2SampleC() {
        XCTAssertEqual(day.puzzle2(Input(.test(sample2c))), 10)
    }

    func testPuzzle2Final() {
        validatePuzzle2(with: 401)
    }
}
