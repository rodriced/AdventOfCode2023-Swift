//
//  D14.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 15/12/2023.
//

final class D14: Day {
    let num = 14

    func puzzle1(_ input: Input) -> Int {
        var grid = input.stringLines.map { Array($0) }

        var yTargets = Array(repeating: Int?.none, count: grid[0].count)

        for y in grid.indices {

            for x in grid[y].indices {
                let char = grid[y][x]

                if let yTarget = yTargets[x] {
                    if char == "O" {
                        grid[y][x] = "."
                        grid[yTarget][x] = "O"
                        yTargets[x] = yTarget + 1
                    } else if char == "#" {
                        yTargets[x] = nil
                    }

                } else {
                    if char == "." {
                        yTargets[x] = y
                    }
                }

            }
        }

        let result = grid.indices.reduce(0) { partial, y in
            partial + (grid.count - y) * grid[y].map { $0 == "O" ? 1 : 0 }.reduce(0, +)
        }

        return result
    }

    final class Grid {
        var real: [[Character]]
        let xRealMax: Int
        let yRealMax: Int
        var orienation: Orientation = .north

        enum Orientation: Int, CaseIterable {
            case north, west, south, east
        }

        init(_ input: Input) {
            let grid = input.stringLines.map { Array($0) }
            xRealMax = grid[0].count - 1
            yRealMax = grid.count - 1
            real = grid
        }

        func translateToReal(_ x: Int, _ y: Int) -> (Int, Int) {
            switch orienation {
            case .north:
                return (x, y)
            case .west:
                return (y, xRealMax - x)
            case .south:
                return (xRealMax - x, yRealMax - y)
            case .east:
                return (yRealMax - y, x)
            }
        }

        var xMax: Int {
            switch orienation {
            case .north, .south:
                return xRealMax
            case .west, .east:
                return yRealMax
            }
        }

        var yMax: Int {
            switch orienation {
            case .north, .south:
                return yRealMax
            case .west, .east:
                return xRealMax
            }
        }

        func charAt(_ x: Int, _ y: Int) -> Character {
            let (x, y) = translateToReal(x, y)
            return real[y][x]
        }

        func updateAt(_ x: Int, _ y: Int, with char: Character) {
            let (x, y) = translateToReal(x, y)
            real[y][x] = char
        }

        var load: Int {
            real.indices.reduce(0) { partial, y in
                partial + (real.count - y) * real[y].map { $0 == "O" ? 1 : 0 }.reduce(0, +)
            }
        }
    }

    func puzzle2(_ input: Input) -> Int {
        let grid = Grid(input)

        var gridsCache: [[[Character]]] = []
        var loadsCache: [Int] = []

        for cycle in 1... {

            for o in Grid.Orientation.allCases {
                grid.orienation = o

                var yTargets = Array(repeating: Int?.none, count: grid.xMax + 1)

                for y in 0 ... grid.yMax {
                    for x in 0 ... grid.xMax {

                        let char = grid.charAt(x, y)

                        if let yTarget = yTargets[x] {
                            if char == "O" {
                                grid.updateAt(x, y, with: ".")
                                grid.updateAt(x, yTarget, with: "O")
                                yTargets[x] = yTarget + 1
                            } else if char == "#" {
                                yTargets[x] = nil
                            }

                        } else {
                            if char == "." {
                                yTargets[x] = y
                            }
                        }

                    }
                }
            }

            loadsCache.append(grid.load)

            if let cycleLoopStartIndex = gridsCache.firstIndex(of: grid.real) {
                let cycleLoopStart = cycleLoopStartIndex + 1
                let endCycleIndex = (1_000_000_000 - cycleLoopStart) % (cycle - cycleLoopStart) + cycleLoopStart - 1
                return loadsCache[endCycleIndex]
            }

            gridsCache.append(grid.real)

        }

        fatalError()
    }

}
