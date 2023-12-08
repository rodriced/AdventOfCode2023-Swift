//
//  D07.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 07/12/2023.
//

final class D07: Day {
    let num = 7

    func valueFromCardV1(_ card: Character) -> Int {
        if let number = Int(String(card)) {
            return number
        }

        guard let idx = Array("TJQKA").firstIndex(of: card) else {
            fatalError("Bad card \(card)")
        }

        return idx + 10
    }

    typealias HandInfo = (strength: Int, vals: [Int], bet: Int)

    func isHand2Greater(hand1: HandInfo, hand2: HandInfo) -> Bool {
        if hand2.strength > hand1.strength {
            return true
        }
        if hand2.strength < hand1.strength {
            return false
        }

        for (val1, val2) in zip(hand1.vals, hand2.vals) {
            if val2 > val1 {
                return true
            }
            if val2 < val1 {
                return false
            }
        }

        return false
    }

    func puzzle1(_ input: Input) -> Int {
        var handInfos = [HandInfo]()

        for l in input.stringLines {
            let parts = l.split(separator: " ")

            let vals = parts[0].map(valueFromCardV1)
            let bet = Int(parts[1])!

            var valGroups: [(count: Int, val: Int)] = {
                var groups = [(count: Int, val: Int)]()
                var vals = vals
                while !vals.isEmpty {
                    let before = vals.count
                    let val = vals.first!
                    vals.removeAll { $0 == val }
                    let count = before - vals.count

                    groups.append((count: count, val: val))
                }
                return groups
            }()

            valGroups.sort { e1, e2 in
                e1.count > e2.count
            }

            let strength: Int = {
                if valGroups[0].count == 5 {
                    return 6
                }
                if valGroups[0].count == 4 {
                    return 5
                }
                if valGroups[0].count == 3 {
                    if valGroups[1].count == 2 {
                        return 4
                    }
                    return 3
                }
                if valGroups[0].count == 2 {
                    if valGroups[1].count == 2 {
                        return 2
                    }
                    return 1
                }
                return 0
            }()

            handInfos.append((strength, vals, bet))
        }

        let result = handInfos
            .sorted(by: isHand2Greater(hand1:hand2:))
            .enumerated()
            .reduce(0) { partial, elt in
                partial + (elt.offset + 1) * elt.element.bet
            }

        return result
    }

    func valueFromCardV2(_ card: Character) -> Int {
        if card == "J" {
            return 1
        }

        if let number = Int(String(card)) {
            return number
        }

        guard let idx = Array("TQKA").firstIndex(of: card) else {
            fatalError("Bad card \(card)")
        }

        return idx + 10
    }

    func puzzle2(_ input: Input) -> Int {
        var handInfos = [HandInfo]()

        for l in input.stringLines {
            let parts = l.split(separator: " ")

            let vals = parts[0].map(valueFromCardV2)
            let bet = Int(parts[1])!

            var (jokers, valGroups): (Int, [(count: Int, val: Int)]) = {
                var groups = [(count: Int, val: Int)]()
                var jokers = 0
                var vals = vals
                while !vals.isEmpty {
                    let before = vals.count
                    let val = vals.first!
                    vals.removeAll { $0 == val }
                    let count = before - vals.count

                    if val == 1 {
                        jokers = count
                    } else {
                        groups.append((count: count, val: val))
                    }
                }
                return (jokers, groups)
            }()

            valGroups.sort { e1, e2 in
                e1.count > e2.count
            }

            let strength: Int = {
                if jokers == 5 {
                    return 6
                }

                valGroups[0].count += jokers

                if valGroups[0].count == 5 {
                    return 6
                }
                if valGroups[0].count == 4 {
                    return 5
                }
                if valGroups[0].count == 3 {
                    if valGroups[1].count == 2 {
                        return 4
                    }
                    return 3
                }
                if valGroups[0].count == 2 {
                    if valGroups[1].count == 2 {
                        return 2
                    }
                    return 1
                }
                return 0
            }()

            handInfos.append((strength, vals, bet))
        }

        let result = handInfos
            .sorted(by: isHand2Greater(hand1:hand2:))
            .enumerated()
            .reduce(0) { partial, elt in
                partial + (elt.offset + 1) * elt.element.bet
            }

        return result
    }

}
