//
//  D16.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 18/12/2023.
//

final class D16: Day {
    let num = 16

    func deltas(char: Character, prevDelta: XY) -> [XY] {
        let oldDx = prevDelta.x
        let oldDY = prevDelta.y

        switch char {
        case "/": return [XY(-oldDY, -oldDx)]
        case "\\": return [XY(oldDY, oldDx)]
        case "|" where oldDY == 0: return [XY(0, -1), XY(0, 1)]
        case "-" where oldDx == 0: return [XY(-1, 0), XY(1, 0)]
        default: return [prevDelta]
        }
    }

    let dirDeltas: [XY] = [XY(0, 1), XY(0, -1), XY(-1, 0), XY(1, 0)]

    func dir(from delta: XY) -> Int {
        dirDeltas.firstIndex(of: delta)!
    }

    func beamForward(initial: XY, prevDelta: XY, _ grid: [[Character]], _ mvtGrid: inout [[[Bool]]]) {
        var pos = initial
        var prevDelta = prevDelta

        func isOutsideGrid(_ p: XY) -> Bool {
            p.x < 0 || p.x > grid[0].count - 1 || p.y < 0 || p.y > grid.count - 1
        }

        while !isOutsideGrid(pos) {
            let dir = dir(from: prevDelta)

            guard mvtGrid[pos.y][pos.x][dir] == false else {
                return
            }

            mvtGrid[pos.y][pos.x][dir] = true

            let char = grid[pos.y][pos.x]
            let newDeltas = deltas(char: char, prevDelta: prevDelta)

            if newDeltas.count == 2 {
                beamForward(initial: pos, prevDelta: newDeltas[1], grid, &mvtGrid)
            }

            prevDelta = newDeltas[0]
            pos += prevDelta
        }
    }

    func countEnergizedTiles(_ mvtGrid: [[[Bool]]]) -> Int {
        mvtGrid.reduce(0) { partial, line in
            partial + line.reduce(0) { partial2, dirs in
                partial2 + (dirs.contains(true) ? 1 : 0)
            }
        }
    }

    func puzzle1(_ input: Input) -> Int {
        let grid = input.stringLines.map { Array($0) }

        var mvtGrid = Array(repeating:
            Array(repeating:
                Array(repeating: false, count: 4),
                count: grid[0].count),
            count: grid.count)

        beamForward(initial: XY(0, 0), prevDelta: XY(1, 0), grid, &mvtGrid)

        return countEnergizedTiles(mvtGrid)
    }

    func puzzle2(_ input: Input) -> Int {
        let grid = input.stringLines.map { Array($0) }

        var mvtGrid = Array(repeating:
            Array(repeating:
                Array(repeating: false, count: 4),
                count: grid[0].count),
            count: grid.count)

        var result = 0

        for delta in dirDeltas {
            let initials: [XY]
            if delta.x == 0 {
                initials = (0 ..< grid[0].endIndex).map { x in XY(x, delta.y == 1 ? 0 : grid.endIndex - 1) }
            } else {
                initials = (0 ..< grid.endIndex).map { y in XY(delta.x == 1 ? 0 : grid[0].endIndex - 1, y) }
            }

            for initial in initials {
                mvtGrid.enumerated().forEach { y, line in
                    line.enumerated().forEach { x, dirs in
                        dirs.indices.forEach { mvtGrid[y][x][$0] = false }
                    }
                }

                beamForward(initial: initial, prevDelta: delta, grid, &mvtGrid)

                result = max(result, countEnergizedTiles(mvtGrid))
            }

        }

        return result
    }

}
