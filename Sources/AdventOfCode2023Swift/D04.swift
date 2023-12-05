//
//  D04.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 05/12/2023.
//

final class D04: Day {
    let num = 4

    func puzzle1(_ input: Input) -> Int {
        var result = 0

        for line in input.stringLines {
            let parts = line.split(separator: " | ")

            let fields1 = parts[0].split(separator: #/\s+/#)
            let fields2 = parts[1].split(separator: #/\s+/#)

            let winNums = Set(fields1[2...].map { Int($0)! })
            let myNums = Set(fields2.map { Int($0)! })

            let nbOfWin = myNums.intersection(winNums).count

            if nbOfWin > 0 {
                result += 1 << (nbOfWin - 1)
            }
        }

        return result
    }

    func puzzle2(_ input: Input) -> Int {
        let lines = input.stringLines

        var cardsQt = Array(repeating: 1, count: lines.count)

        for (i, line) in lines.enumerated() {
            let parts = line.split(separator: " | ")

            let fields1 = parts[0].split(separator: #/\s+/#)
            let fields2 = parts[1].split(separator: #/\s+/#)

            let winNums = Set(fields1[2...].map { Int($0)! })
            let myNums = Set(fields2.map { Int($0)! })

            let nbOfWin = myNums.intersection(winNums).count

            if nbOfWin > 0 {
                (i + 1 ... min(i + nbOfWin, lines.count - 1)).forEach {
                    cardsQt[$0] += cardsQt[i]
                }
            }
        }

        return cardsQt.reduce(0, +)
    }

}
