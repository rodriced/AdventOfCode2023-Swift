//
//  D11.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 11/12/2023.
//

final class D11: Day {
    let num = 11

    struct Galaxy {
        let x: Int
        let y: Int

        init(_ x: Int, _ y: Int) {
            self.x = x
            self.y = y
        }

        func dist(with other: Self) -> Int {
            abs(x - other.x) + abs(y - other.y)
        }
    }

    func puzzle1(_ input: Input) -> Int {
        let input = input.dataLines

        var galaxies: [Galaxy] = []

        let emptyCols: [Bool] = input[0].indices.map { x in
            input.indices.allSatisfy { y in
                input[y][input[y].startIndex + x] == Character(".").asciiValue
            }
        }

        var xExp = 0
        var yExp = 0

        for (y, line) in input.enumerated() {
            if !line.contains(where: { $0 != Character(".").asciiValue }) {
                yExp += 1
                continue
            }

            xExp = 0
            for (x, char) in line.enumerated() {
                if emptyCols[x] {
                    xExp += 1
                    continue
                }

                if char == Character("#").asciiValue {
                    galaxies.append(Galaxy(x + xExp, y + yExp))
                }
            }
        }

        return galaxies.combinations(ofCount: 2).reduce(0) { partial, pair in
            partial + pair[0].dist(with: pair[1])
        }
    }

    func puzzle2(_ input: Input) -> Int {
        let input = input.dataLines

        var galaxies: [Galaxy] = []

        let emptyCols: [Bool] = input[0].indices.map { x in
            input.indices.allSatisfy { y in
                input[y][input[y].startIndex + x] == Character(".").asciiValue
            }
        }

        var xExp = 0
        var yExp = 0

        for (y, line) in input.enumerated() {
            if !line.contains(where: { $0 != Character(".").asciiValue }) {
                yExp += 1_000_000 - 1
                continue
            }

            xExp = 0
            for (x, char) in line.enumerated() {
                if emptyCols[x] {
                    xExp += 1_000_000 - 1
                    continue
                }

                if char == Character("#").asciiValue {
                    galaxies.append(Galaxy(x + xExp, y + yExp))
                }
            }
        }

        return galaxies.combinations(ofCount: 2).reduce(0) { partial, pair in
            partial + pair[0].dist(with: pair[1])
        }
    }

}
