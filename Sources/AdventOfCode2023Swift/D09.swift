//
//  D09.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 09/12/2023.
//

final class D09: Day {
    let num = 9

    func puzzle1(_ input: Input) -> Int {
        let histories = input.stringLines.map {
            $0.split(separator: " ").map { Int($0)! }
        }

        var nextVals: [Int] = []

        for history in histories {
            var sequences = [history]
            var i = 0
            repeat {
                let seq = sequences[i]

                let newSeq = (0 ... seq.count - 2).map { seq[$0 + 1] - seq[$0] }

                sequences.append(newSeq)
                i += 1

            } while !sequences.last!.allSatisfy { $0 == 0 }

            nextVals.append(
                sequences.map { $0.last! }
                    .reduce(0, +)
            )
        }

        return nextVals.reduce(0, +)
    }

    func puzzle2(_ input: Input) -> Int {
        let histories = input.stringLines.map {
            $0.split(separator: " ").map { Int($0)! }
        }

        var backVals: [Int] = []

        for history in histories {
            var sequences = [history]
            var i = 0
            repeat {
                let seq = sequences[i]

                let newSeq = (0 ... seq.count - 2).map { seq[$0 + 1] - seq[$0] }

                sequences.append(newSeq)
                i += 1

            } while !sequences.last!.allSatisfy { $0 == 0 }

            backVals.append(
                sequences.enumerated().reduce(0) { partial, v in
                    partial + ((v.offset % 2) != 0 ? -1 : 1) * v.element.first!
                }
            )
        }

        return backVals.reduce(0, +)
    }
}
