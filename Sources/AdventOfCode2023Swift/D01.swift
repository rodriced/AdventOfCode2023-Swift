//
//  D01.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 03/12/2023.
//

import Foundation

final class D01: Day {
    let num = 1

    func puzzle1(_ input: Input) -> Int {
        let result = input.stringLines
            .map { l in
                let d1 = l.first { $0.isNumber }
                let d2 = l.last { $0.isNumber }

                return Int("\(d1!)\(d2!)")!
            }
            .reduce(0, +)

        return result
    }

    let digits = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"].map { Data($0.utf8) }
    lazy var revDigits = digits.map { Data($0.reversed()) }

    func isBetween1And9(_ char: UInt8) -> Bool {
        char >= Character("1").asciiValue! && char <= Character("9").asciiValue!
    }

    func puzzle2(_ input: Input) -> Int {
        let result = input.dataLines
            .map { l in
                let rev = Data(l.reversed())

                var iD1 = l.firstIndex(where: isBetween1And9) ?? l.count
                var iD2 = rev.firstIndex(where: isBetween1And9) ?? rev.count

                var d1 = iD1 == l.count ? 0 : Int(ascii: l[iD1])!
                var d2 = iD2 == rev.count ? 0 : Int(ascii: rev[iD2])!

                for n in 1 ... 9 {
                    let newID1 = l.range(of: digits[n - 1])?.lowerBound

                    if let newID1, newID1 < iD1 {
                        iD1 = newID1
                        d1 = n
                    }

                    let newID2 = rev.range(of: revDigits[n - 1])?.lowerBound

                    if let newID2, newID2 < iD2 {
                        iD2 = newID2
                        d2 = n
                    }
                }

                return Int("\(d1)\(d2)")!
            }
            .reduce(0, +)

        return result
    }
}

extension Int {
    init?(ascii val: UInt8) {
        let result = Int(val - Character("0").asciiValue!)
        
        guard result >= 0, result <= 9 else {
            return nil
        }
        
        self = result
    }
}
