//
//  D06.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 06/12/2023.
//

import Foundation

final class D06: Day {
    let num = 6

    func puzzle1(_ input: Input) -> Int {
        let fields = input.stringLines.map {
            $0.split(separator: #/\s+/#)
                .dropFirst()
                .map { Double($0)! }
        }

        return zip(fields[0], fields[1])
            .map { time, dist in
                let delta = time * time - 4.0 * dist

                let tHold1Rec = (time - sqrt(delta)) / 2.0
                let tHold2Rec = (time + sqrt(delta)) / 2.0

                let tHold1 = Int(ceil(tHold1Rec)) + (floor(tHold1Rec) == tHold1Rec ? 1 : 0)
                let tHold2 = Int(floor(tHold2Rec)) - (floor(tHold2Rec) == tHold2Rec ? 1 : 0)

                return tHold2 - tHold1 + 1
            }
            .reduce(1, *)
    }

    func puzzle2(_ input: Input) -> Int {
        let fields = input.stringLines.map {
            $0.split(separator: #/\s+/#)
                .dropFirst()
                .joined()
                .map { $0 }
        }

        let time = Double(String(fields[0]))!
        let dist = Double(String(fields[1]))!

        let delta = time * time - 4.0 * dist

        let tHold1Rec = (time - sqrt(delta)) / 2.0
        let tHold2Rec = (time + sqrt(delta)) / 2.0

        let tHold1 = Int(ceil(tHold1Rec)) + (floor(tHold1Rec) == tHold1Rec ? 1 : 0)
        let tHold2 = Int(floor(tHold2Rec)) - (floor(tHold2Rec) == tHold2Rec ? 1 : 0)

        return (tHold2 - tHold1) + 1
    }
}
