//
//  D03.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 04/12/2023.
//

final class D03: Day {
    let num = 3

    func puzzle1(_ input: Input) -> Int {
        let array = input.stringLines.map { Array($0) }
        let maxXY = XY(array.count - 1, array[0].count - 1)

        var result = 0
        var numDigits = [Character]()
        var adjacentSymbolFound = false

        for (y, line) in array.enumerated() {

            for (x, char) in line.enumerated() {
                guard char.isNumber else {
                    continue
                }

                if !adjacentSymbolFound {
                    adjacentSymbolFound = XY(x, y).allAroundAdjacents(limit: maxXY)
                        .contains { adjacentXY in
                            let adjacentChar = array[adjacentXY.y][adjacentXY.x]
                            return adjacentChar != "." && !adjacentChar.isNumber
                        }
                }

                numDigits.append(char)

                if x == maxXY.x || !line[x + 1].isNumber {

                    if adjacentSymbolFound {
                        let num = Int(String(numDigits))!
                        result += num
                        adjacentSymbolFound = false
                    }

                    numDigits = []
                }
            }

        }

        return result
    }

    func puzzle2(_ input: Input) -> Int {
        let array = input.stringLines.map { Array($0) }
        let maxXY = XY(array.count - 1, array[0].count - 1)

        var result = 0

        for (y, line) in array.enumerated() {

            for (x, char) in line.enumerated() {
                guard char == "*" else {
                    continue
                }

                var adjNumbersXY = XY(x, y).allAroundAdjacents(limit: maxXY)
                    .filter { xy in array[xy.y][xy.x].isNumber }

                var numBounds: [(x1: Int, x2: Int, y: Int)] = []

                while adjNumbersXY.count > 0 && numBounds.count < 2 {
                    let adjBox = adjNumbersXY.remove(at: 0)

                    var numMinX = adjBox.x - 1
                    var numMaxX = adjBox.x + 1

                    while numMinX >= 0, array[adjBox.y][numMinX].isNumber {
                        adjNumbersXY.removeAll { box in
                            box.x == numMinX && box.y == adjBox.y
                        }

                        numMinX -= 1
                    }

                    while numMaxX <= maxXY.x, array[adjBox.y][numMaxX].isNumber {
                        adjNumbersXY.removeAll { box in
                            box.x == numMaxX && box.y == adjBox.y
                        }

                        numMaxX += 1
                    }

                    numBounds.append((x1: numMinX + 1, x2: numMaxX - 1, y: adjBox.y))
                }

                guard numBounds.count == 2 else {
                    continue
                }

                result += numBounds.reduce(1) { partialResult, bounds in
                    let (x1, x2, y) = bounds
                    return partialResult * Int(String(array[y][x1 ... x2]))!
                }

            }

        }

        return result
    }
}
