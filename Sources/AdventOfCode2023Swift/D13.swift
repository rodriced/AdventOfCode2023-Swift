//
//  D13.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 14/12/2023.
//

import CoreFoundation

final class D13: Day {
    let num = 13

    struct Terrain {
        let grids: [[Int32]]
        var sym: (p: Int, i: Int)

        init(grids: [[Int32]]) {
            self.grids = grids
            sym = (p: -1, i: -1)
        }
    }

    func printGrid(terrain: Terrain, gridPart: Int?) {
        let gridParts = gridPart.map { [$0] } ?? [0, 1]

        gridParts.forEach { p in
            let length = terrain.grids[abs(1 - p)].count

            print("  ", terminator: "")
            (0 ..< length).forEach { print($0 % 10, terminator: " ") }
            print()

            terrain.grids[p].enumerated().forEach { l, line in
                print(l % 10, terminator: " ")
                print(bitString(line, length: length))
            }
        }
    }

    // We are going to manipulate bits arrays (for fun and learning purpose)
    func bitString(_ v: Int32, length: Int = 20) -> String {
        let s = String(v, radix: 2).reversed().map { Character($0 == "1" ? "#" : ".") }
        let pad = String(repeating: ".", count: length - s.count)
        return String((s + pad).map { "\($0)" }.joined(by: " "))
    }

    func parseInput(_ input: Input) -> [Terrain] {
        var r = -1
        var rows = [Int32]()
        var cols = [Int32]()
        var terrains = [Terrain]()

        for line in input.stringLines {
            //            print(line)
            if line.isEmpty {
                r = -1
                terrains.append(Terrain(grids: [rows, cols]))
                continue
            }
            if r == -1 {
                rows = [Int32]()
                cols = Array(repeating: Int32.zero, count: line.count)
            }

            r += 1

            var row = Int32.zero
            for (c, char) in line.enumerated() {
                let bit: Int32 = char == Character("#") ? 1 : 0
                row |= bit << c
                cols[c] |= bit << r
            }
            rows.append(row)
        }

        terrains.append(Terrain(grids: [rows, cols]))

        return terrains
    }

    func puzzle1(_ input: Input) -> Int {
        let terrains = parseInput(input)

        var result = 0

        nextTerrain: for terrain in terrains {

            for (p, lines) in terrain.grids.enumerated() {

                searchSym: for i in lines.indices.dropLast() {

                    if lines[i] == lines[i + 1] {
                        let jMax = min(i, lines.count - i - 2)

                        if jMax > 0 {
                            for j in 1 ... jMax {
                                if lines[i - j] != lines[i + j + 1] {
                                    continue searchSym
                                }
                            }
                        }

                        print(i)
                        let n = i + 1
                        let localResult = p == 0 ? n * 100 : n
                        result += localResult
                        continue nextTerrain
                    }

                }
            }
        }

        return result
    }

    func whichBitIsDifferent(_ a: Int32, _ b: Int32) -> Int? {
        return Int(exactly: log2(Float(abs(a ^ b))))
    }

    func haveOnlyOneDiff(_ a: Int32, _ b: Int32) -> Bool {
        guard a != b else {
            return false
        }

        return whichBitIsDifferent(a, b) != nil
    }

    func puzzle2(_ input: Input) -> Int {
        let terrains = parseInput(input)

        var result = 0

        nextTerrain: for terrain in terrains {

            for (p, lines) in terrain.grids.enumerated() {

                searchSym: for i in lines.indices.dropLast() {
                    guard (p, i) != terrain.sym else {
                        continue
                    }

                    var areSymmetrical = lines[i] == lines[i + 1]
                    let hasASmudgeFirst = haveOnlyOneDiff(lines[i], lines[i + 1])
                    var hasASmudge = hasASmudgeFirst

                    if areSymmetrical || hasASmudgeFirst {
                        let jMax = min(i, lines.count - i - 2)

                        if jMax > 0 {
                            for j in 1 ... jMax {

                                let line1 = lines[i - j]
                                let line2 = lines[i + j + 1]

                                areSymmetrical = line1 == line2
                                let currentHasSmudge = haveOnlyOneDiff(line1, line2)

                                if hasASmudge {
                                    if !areSymmetrical {
                                        continue searchSym
                                    }
                                } else {
                                    if !currentHasSmudge && !areSymmetrical {
                                        continue searchSym
                                    }

                                    hasASmudge = currentHasSmudge
                                }

                            }
                        }

                        if !hasASmudge {
                            continue searchSym
                        }

                        let n = i + 1
                        let localResult = p == 0 ? n * 100 : n
                        result += localResult
                        continue nextTerrain
                    }

                }
            }
        }

        return result
    }
}
