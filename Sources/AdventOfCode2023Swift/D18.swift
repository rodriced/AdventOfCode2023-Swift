//
//  D18.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 21/12/2023.
//

final class D18: Day {
    let num = 18

    enum Direction: Int, CaseIterable, CustomStringConvertible {
        case right, down, left, up

        static let deltas: [XY] = [XY(1, 0), XY(0, 1), XY(-1, 0), XY(0, -1)]

        var delta: XY { Self.deltas[rawValue] }

        init<S: StringProtocol>(_ str: S) {
            self.init(str.first!)
        }
        
        init(_ char: Character) {
            switch char {
            case "R": self = .right
            case "D": self = .down
            case "L": self = .left
            case "U": self = .up
            default:
                fatalError()
            }
        }

        init?(_ delta: XY) {
            guard delta.x == 0 || delta.y == 0 else { return nil }

            let unitDelta = XY(delta.x.signum(), delta.y.signum())

            self.init(rawValue: Self.deltas.firstIndex(of: unitDelta)!)
        }

        var description: String {
            ["R", "D", "L", "U"][rawValue]
        }

        static let symbol: [Character] = [">", "v", "<", "^"]

        var orthogonals: [Self] {
            self == .up || self == .down ? [.left, .right] : [.up, .down]
        }
    }

    struct Trench: CustomStringConvertible {
        let dir: Direction
        var dist: Int
        var start: XY
        var end: XY

        init(dir: Direction, dist: Int, start: XY) {
            self.dir = dir
            self.dist = dist
            self.start = start
            end = start + dist * dir.delta
        }

        init(dir: Character, dist: Int, start: XY) {
            let dir = Direction(dir)
            self.init(dir: dir, dist: dist, start: start)
        }

        init(dir: Int, dist: Int, start: XY) {
            let dir = Direction(rawValue: dir)!
            self.init(dir: dir, dist: dist, start: start)
        }

        var description: String {
            "\(dir) \(dist)"
        }
    }

    enum Elt: CustomStringConvertible {
        case none, horizontal, vertical, corner(Bool)

        var isDug: Bool { if case .none = self { false } else { true } }

        var description: String {
            switch self {
            case .none: "."
            case .horizontal: "-"
            case .vertical: "|"
            case let .corner(isUp): isUp ? "^" : "v"
            }
        }
    }

    func printEltsGrid(_ grid: [[Elt]]) {
        for line in grid {
            for elt in line {
                print(elt, terminator: "")
            }
            print()
        }
    }

    func puzzle1(_ input: Input) -> Int {
        let regex = #/(?<dir>[UDLR]{1}) (?<dist>\d+) \(#[0-9a-f]{6}\)/#

        var pos = XY(0, 0)

        let trenches = input.stringLines.map {
            let match = $0.wholeMatch(of: regex)!
            let trench = Trench(dir: match.dir.first!, dist: Int(match.dist)!, start: pos)
            pos = trench.end
            return trench
        }

        let xMin = trenches.filter { $0.dir == .left }.map(\.end.x).min()!
        let xMax = trenches.filter { $0.dir == .right }.map(\.end.x).max()!
        let yMin = trenches.filter { $0.dir == .up }.map(\.end.y).min()!
        let yMax = trenches.filter { $0.dir == .down }.map(\.end.y).max()!

        let size = XY(xMax - xMin + 1, yMax - yMin + 1)
        let orig = XY(xMin, yMin)

        var grid = Array(repeating: Array(repeating: Elt.none, count: size.x), count: size.y)

        for t in trenches {
            let p0 = t.start - orig
            let elt: Elt = t.dir == .up || t.dir == .down ? .vertical : .horizontal
            for step in 1 ... t.dist {
                let p = p0 + step * t.dir.delta

                grid[p.y][p.x] = elt

            }
            if t.dir == .up || t.dir == .down {
                grid[p0.y][p0.x] = .corner(t.dir == .down)
                let p1 = p0 + t.dist * t.dir.delta
                grid[p1.y][p1.x] = .corner(t.dir == .up)
            }
        }

//        printEltsGrid(grid)

        var result = 0

        for line in grid {
            var isIn = false
            var lastCornerDir: Bool? = nil

            for elt in line {

                switch (elt, lastCornerDir) {
                case (.vertical, _):
                    // Passing through a vertical trench
                    isIn.toggle()
                case let (.corner(cornerDir), nil):
                    // Horizontal trench start
                    lastCornerDir = cornerDir
                case let (.corner(cornerDir), .some(lastDir)):
                    // Horizontal trench end
                    if lastDir != cornerDir {
                        isIn.toggle()
                    }
                    lastCornerDir = nil
                default:
                    break
                }

                if isIn || elt.isDug {
                    result += 1
                }
            }

        }

        return result
    }

    func puzzle2(_ input: Input) -> Int {
        let regex = #/[UDLR]{1} \d+ \(#(?<distHexa>[0-9a-f]{5})(?<dir>[0-3]{1})\)/#

        var pos = XY(0, 0)

        let trenches = input.stringLines.map {
            let match = $0.wholeMatch(of: regex)!
            let trench = Trench(dir: Int(String(match.dir.first!))!,
                                dist: Int(match.distHexa, radix: 16)!,
                                start: pos)
            pos = trench.end
            return trench
        }

        let xs = trenches.map(\.start.x).uniqued().sorted().map { $0 }
        let ys = trenches.map(\.start.y).uniqued().sorted().map { $0 }
        
//        let xMin = xs.first!
//        let xMax = xs.last!
//        let yMin = ys.first!
//        let yMax = ys.last!

        var xGaps = xs.windows(ofCount: 2).map { $0.last! - $0.first! - 1 }
        var yGaps = ys.windows(ofCount: 2).map { $0.last! - $0.first! - 1 }
        xGaps.append(0)
        yGaps.append(0)

        let unitSize = XY(xs.count, ys.count)

        let unitTrenches = trenches.map { t in
            let startX = xs.firstIndex(of: t.start.x)!
            let startY = ys.firstIndex(of: t.start.y)!
            let start = XY(startX, startY)
            let dist: Int

            if [.up, .down].contains(t.dir) {
                let endY = ys.firstIndex(of: t.end.y)!
                dist = abs(endY - startY)
            } else {
                let endX = xs.firstIndex(of: t.end.x)!
                dist = abs(endX - startX)

            }
            return Trench(dir: t.dir, dist: dist, start: start)
        }

        var grid = Array(repeating: Array(repeating: Elt.none, count: unitSize.x), count: unitSize.y)

        for t in unitTrenches {
            let p0 = t.start
            let elt: Elt = t.dir == .up || t.dir == .down ? .vertical : .horizontal
            for step in 1 ... t.dist {
                let p = p0 + step * t.dir.delta

                grid[p.y][p.x] = elt

            }
            if t.dir == .up || t.dir == .down {
                grid[p0.y][p0.x] = .corner(t.dir == .down)
                let p1 = p0 + t.dist * t.dir.delta
                grid[p1.y][p1.x] = .corner(t.dir == .up)
            }
        }

//        printEltsGrid()

        var result = 0

        for (y, line) in grid.enumerated() {
            var isIn = false
            var inSegment = false
            let yGap = yGaps[y]

            for (x, elt) in line.enumerated() {
                var eltResult = 0
                let xGap = xGaps[x]

                switch (elt, inSegment) {
                case (.horizontal, true):
                    eltResult = xGap + 1

                    // Passing through a vertical trench (segement)
                    if isIn {
                        eltResult += (xGap + 1) * yGap
                    }
                case (.vertical, false):
                    // Passing through a vertical trench
                    eltResult = yGap + 1

                    isIn.toggle()
                    if isIn {
                        eltResult += xGap * (yGap + 1)
                    }
                case let (.corner(isCornerUp), false):
                    // Horizontal trench started
                    eltResult = xGap + 1

                    if isCornerUp {
                        eltResult += yGap

                        isIn.toggle()

                        if isIn {
                            eltResult += xGap * yGap
                        }
                    } else {
                        if isIn {
                            eltResult += (xGap + 1) * yGap
                        }
                    }

                    inSegment = true
                case let (.corner(isCornerUp), true):
                    // Horizontal trench closed
                    if isCornerUp {
                        eltResult = yGap + 1

                        isIn.toggle()

                        if isIn {
                            eltResult += xGap * (yGap + 1)
                        }
                    } else {
                        if isIn {
                            eltResult = (xGap + 1) * (yGap + 1)
                        } else {
                            eltResult = 1
                        }
                    }

                    inSegment = false
                case (.none, false):
                    if isIn {
                        eltResult = (xGap + 1) * (yGap + 1)
                    }
                default:
                    fatalError()
                }

//                print(x, y, elt,
//                      isLastCornerUp.map { "(\($0 ? "^" : "v"))" } ?? "   ",
//                      isInBelow ? "__" : "  ",
//                      isInAfter ? ">>" : "  ",
//                      eltResult)

                if eltResult > 0 {
                    result += eltResult
                }

            }

        }

        return result
    }

}
