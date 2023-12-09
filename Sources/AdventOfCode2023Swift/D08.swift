//
//  D08.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 08/12/2023.
//

import Algorithms

final class D08: Day {
    let num = 8

    func puzzle1(_ input: Input) -> Int {
        let lines = input.stringLines

        let dirs = lines[0].map { $0 == "L" ? 0 : 1 }

        let regex = #/(?<parent>[A-Z0-9]{3}) = \((?<leftChild>[A-Z0-9]{3})\, (?<rightChild>[A-Z0-9]{3})\)/#

        var dict = [String: (n: Int, d: [String])]()

        for line in lines[2...].enumerated() {
            let match = line.element.wholeMatch(of: regex)!
            dict[String(match.parent)] = (n: line.offset, d: [String(match.leftChild), String(match.rightChild)])
        }

        var current = "AAA"
        for (n, dir) in dirs.cycled().enumerated() {
            if current == "ZZZ" {
                return n
            }

            current = dict[current]!.d[dir]
        }

        fatalError("Can't find ZZZ")
    }

    func puzzle2(_ input: Input) -> Int {
        let lines = input.stringLines

        let dirs = lines[0].map { $0 == "L" ? 0 : 1 }

        let regex = #/(?<node>[A-Z0-9]{3}) = \((?<leftChild>[A-Z0-9]{3})\, (?<rightChild>[A-Z0-9]{3})\)/#
        var nodes: [String: [String]] = [:]
        var starts: [String] = []

        for line in lines[2...] {
            if let match = line.wholeMatch(of: regex) {
                let n = String(match.node)

                nodes[n] = [String(match.leftChild), String(match.rightChild)]

                if n.last! == "A" {
                    starts.append(n)
                }
            }
        }

        var steps = [Int]()

        for start in starts {
            var n = start
            var i = 0
            for dir in dirs.cycled() {
                let node = nodes[n]!

                if n.last! == "Z" {
                    steps.append(i)
                    break
                }

                n = node[dir]
                i += 1
            }
        }

        return Math.findLeastCommonMultiple(steps)
    }
}
