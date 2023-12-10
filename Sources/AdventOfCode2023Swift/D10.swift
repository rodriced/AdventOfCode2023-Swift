//
//  D10.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 10/12/2023.
//

private extension XY {
    static let pipesInfos: [(pipe: Character, io: [XY])] = [
        (pipe: "|", io: [XY(0, -1), XY(0, 1)]),
        (pipe: "-", io: [XY(1, 0), XY(-1, 0)]),
        (pipe: "L", io: [XY(0, -1), XY(1, 0)]),
        (pipe: "J", io: [XY(-1, 0), XY(0, -1)]),
        (pipe: "7", io: [XY(-1, 0), XY(0, 1)]),
        (pipe: "F", io: [XY(1, 0), XY(0, 1)]),
    ]

    static func guessPipe(at p: XY, between others: [XY]) -> Character {
        let io0 = others[0] - p
        let io1 = others[1] - p

        return pipesInfos.first {
            $0.io == [io0, io1] || $0.io == [io1, io0]
        }!.pipe
    }

    static func nextDelta(pipe: Character, prevDelta: XY) -> XY {
        let info = pipesInfos.first { $0.pipe == pipe }!
        return prevDelta == info.io[0] ? info.io[1] : info.io[0]
    }

    func next(pipe: Character, prev: XY) -> XY {
        self + Self.nextDelta(pipe: pipe, prevDelta: prev - self)
    }

    func isConnected(pipe: Character, to p: XY) -> Bool {
        let prevDelta = p - self
        return Self.pipesInfos.first { $0.pipe == pipe }
            .map { info in
                info.io.first { $0 == prevDelta } != nil
            }
            ?? false
    }
}

final class D10: Day {
    let num = 10

    func puzzle1(_ input: Input) -> Int {
        let grid = input.stringLines.map { Array($0) }

        let max = XY(grid[0].count - 1, grid.count - 1)

        let start = {
            for (y, row) in grid.enumerated() {
                if let x = row.firstIndex(of: "S") {
                    return XY(x, y)
                }
            }
            fatalError("No start found")
        }()

        func char(from p: XY) -> Character { grid[p.y][p.x] }

        var prevs = [start, start]
        var currents: [XY] = start.adjacents(limit: max)
            .filter {
                $0.isConnected(pipe: char(from: $0), to: start)
            }

        var steps = 1

        while currents[0] != currents[1]
            && currents[0].next(pipe: char(from: currents[0]), prev: prevs[0]) != currents[1]
        {

            let nexts = zip(prevs, currents).map { prev, current in
                current.next(pipe: char(from: current), prev: prev)
            }

            (prevs, currents) = (currents, nexts)
            steps += 1
        }

        return steps
    }

    func puzzle2(_ input: Input) -> Int {
        var grid = input.stringLines.map { Array($0) }

        let max = XY(grid[0].count - 1, grid.count - 1)
        func char(from p: XY) -> Character { grid[p.y][p.x] }

        let start = {
            for (y, row) in grid.enumerated() {
                if let x = row.firstIndex(of: "S") {
                    return XY(x, y)
                }
            }
            fatalError("No start found")
        }()

        let pathEntries: [XY] = start.adjacents(limit: max)
            .filter {
                $0.isConnected(pipe: char(from: $0), to: start)
            }
        let startPipe = XY.guessPipe(at: start, between: pathEntries)

        grid[start.y][start.x] = startPipe

        var path: [XY] = [start]

        var prev = start
        var current = pathEntries[0]
        while current != start {
            path.append(current)

            let next = current.next(pipe: char(from: current), prev: prev)
            (prev, current) = (current, next)
        }

        var grid2 = (0 ..< grid.count).map { _ in
            Array(repeating: Character("."), count: grid[0].count)
        }
        path.forEach { p in grid2[p.y][p.x] = char(from: p) }

        var surface = 0
        var openingCorner = Character?.none

        for row in grid2 {
            var inside = false

            for c in row {

                if c == "|" {
                    inside = !inside
                    continue
                }

                if inside && c == "." {
                    surface += 1
                    continue
                }

                if ["7", "J"].contains(c), let openingCorner {
                    switch (openingCorner, c) {
                    case ("F", "J"), ("L", "7"):
                        inside = !inside
                    default:
                        break
                    }
                }

                if ["F", "L"].contains(c) {
                    openingCorner = c
                }
            }

        }

        return surface
    }

}
