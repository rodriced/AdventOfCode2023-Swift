//
//  XY.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 04/12/2023.
//

struct XY: AdditiveArithmetic, CustomStringConvertible {
    var description: String { "{\(x),\(y)}" }

    let x: Int
    let y: Int

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    static var zero = XY(0, 0)
    static func + (lhs: XY, rhs: XY) -> XY {
        XY(lhs.x + rhs.x, lhs.y + rhs.y)
    }

    static func - (lhs: XY, rhs: XY) -> XY {
        XY(lhs.x - rhs.x, lhs.y - rhs.y)

    }

    static var allAroundAdjacentDeltas: [XY] = [-1, 0, 1].flatMap { dx in
        [-1, 0, 1].map { dy in XY(dx, dy) }
    }
    .filter { $0 != XY(0, 0) }

    static let adjacentDeltas: [XY] = [XY(0, 1), XY(0, -1), XY(-1, 0), XY(1, 0)]

    func isOutside(limit: XY) -> Bool {
        x < 0 || x > limit.x || y < 0 || y > limit.y
    }

    func allAroundAdjacents(limit: XY) -> [XY] {
        Self.allAroundAdjacentDeltas.map {
            self + $0
        }
        .filter {
            !$0.isOutside(limit: limit)
        }
    }
    
    func adjacents(limit: XY) -> [XY] {
        Self.adjacentDeltas.map {
            self + $0
        }
        .filter {
            !$0.isOutside(limit: limit)
        }
    }
}
