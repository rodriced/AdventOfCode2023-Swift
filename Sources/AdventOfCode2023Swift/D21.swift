//
//  D21.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 30/12/2023.
//

private struct Grid<T> {
    private(set) var elts: [[T]]

    let size: XY
    let limit: XY

    init(_ vals: [[T]]) {
        elts = vals
        size = XY(elts[0].count, elts.count)
        limit = XY(elts[0].count - 1, elts.count - 1)
    }

    init(size: XY, elt: T) {
        self.init(Array(repeating:
            Array(repeating: elt, count: size.x),
            count: size.y)
        )
    }

    subscript(_ p: XY) -> T {
        get {
            elts[p.y][p.x]
        }
        set(elt) {
            elts[p.y][p.x] = elt
        }
    }

    func valAt(x: Int, y: Int) -> T {
        return elts[y][x]
    }

    mutating func updateAt(x: Int, y: Int, with elt: T) {
        elts[y][x] = elt
    }

    let deltas: [XY] = [XY(1, 0), XY(0, 1), XY(-1, 0), XY(0, -1)]

    func neighbours(for pos: XY) -> [XY] {
        deltas.map { d in
            pos + d
        }
        .filter { p in
            !p.isOutside(limit: limit)
//            p.x >= 0 || p.x <= limit.x || p.y >= 0 || p.y <= limit.y
        }
    }
}

private extension Grid where T == Character {
    func walkableNeighbours(for pos: XY) -> [XY] {
        neighbours(for: pos)
            .filter { self[$0] != "#" }
    }
}

final class D21: Day {
    let num = 21

    var maxSteps: Int = 64

    func puzzle1(_ input: Input) -> Int {
        var start = XY(-1, -1)

        let garden = Grid(input.stringLines.map { Array($0) })

        for (y, row) in garden.elts.enumerated() {
            if let x = row.firstIndex(of: "S") {
                start = XY(x, y)
                break
            }
        }

        var currents: Set<XY> = [start]

        for _ in 1 ... maxSteps {
            var nexts: Set<XY> = []

            for current in currents {
                nexts = nexts.union(garden.walkableNeighbours(for: current))
            }

            currents = nexts
        }

        return currents.count

    }

    func puzzle2(_ input: Input) -> Int {
        return 0
    }
}
