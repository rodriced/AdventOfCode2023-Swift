//
//  D19.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 26/12/2023.
//

import Foundation

final class D19: Day {
    let num = 19

    struct Rule: CustomStringConvertible {
        struct Cond: CustomStringConvertible {
            let cat: Int
            let val: Int
            let comp: String

            init(cat: Int, val: Int, comp: String) {
                self.cat = cat
                self.val = val
                self.comp = comp
            }

            var fn: ([Int]) -> Bool {
                comp == ">" ? { $0[cat] > val } : { $0[cat] < val }
            }

            var ranges: [ClosedRange<Int>] {
                comp == "<" ? [1 ... val - 1, val ... 4000] : [val + 1 ... 4000, 1 ... val]
            }

            var description: String { "\(Array("xmas")[cat])\(comp)\(val)" }

        }

        let cond: Cond?
        let dest: String

        init(cat: Int, comp: String, val: Int, dest: String) {
            cond = Cond(cat: cat, val: val, comp: comp)
            self.dest = dest
        }

        init(dest: String) {
            cond = nil
            self.dest = dest
        }

        var description: String { "\(cond?.description ?? ""):\(dest)" }

        func apply(to part: [Int]) -> String? {
            guard let cond else {
                return dest
            }

            return cond.fn(part) ? dest : nil
        }

        func apply(to parts: [ClosedRange<Int>]) -> (String, [ClosedRange<Int>], [ClosedRange<Int>]) {
            guard let cond else {
                return (dest, parts, [])
            }

            let cat = cond.cat
            var selectedParts = parts
            selectedParts[cat] = parts[cat].clamped(to: cond.ranges[0])

            var unselectedParts = parts
            unselectedParts[cat] = parts[cat].clamped(to: cond.ranges[1])

            return (dest, selectedParts, unselectedParts)
        }
    }

    func decodeWorkflowsSection(_ section: ArraySlice<Substring>) -> [String: [Rule]] {
        let workflowRegex = #/(?<wfName>[a-zAR]{1,3}){(?<rules>.+)}/#
        let ruleRegex = #/(?<cat>[xmas]{1})(?<comp>[<>]{1})(?<val>\d+):(?<dest>[a-zAR]{1,3})/#

        var workflows: [String: [Rule]] = [:]

        for line in section {
            let match = line.wholeMatch(of: workflowRegex)!
            let rulesStr = match.rules.split(separator: ",")
            var rules: [Rule] = rulesStr.dropLast().map {
                let match = $0.wholeMatch(of: ruleRegex)!
                let cat = Array("xmas").firstIndex(of: match.cat.first!)!
                return Rule(cat: cat, comp: String(match.comp), val: Int(match.val)!, dest: String(match.dest))
            }
            rules.append(Rule(dest: String(rulesStr.last!)))
            workflows[String(match.wfName)] = rules
        }

        return workflows
    }

    func puzzle1(_ input: Input) -> Int {
        let sections = input.stringLines.split(separator: [""])

        let workflows = decodeWorkflowsSection(sections[0])

        let parts = sections[1].map {
            let part = $0.dropFirst().dropLast()
            let partRatings = part.split(separator: ",").map {
                Int($0.dropFirst(2))!
            }
            return partRatings
        }

        var result = 0

        nextPart: for part in parts {
            var workflowRules = workflows["in"]!

            nextWorkflow: while true {
                for rule in workflowRules {
                    let dest = rule.apply(to: part)

                    guard let dest else {
                        continue
                    }

                    switch dest {
                    case "A":
                        result += part.reduce(0, +)
                        fallthrough
                    case "R":
                        continue nextPart
                    default:
                        workflowRules = workflows[dest]!
                        continue nextWorkflow
                    }
                }
            }

        }

        return result
    }

    func puzzle2(_ input: Input) -> Int {
        let sections = input.stringLines.split(separator: [""])

        let workflows = decodeWorkflowsSection(sections[0])

        let parts = Array(repeating: 1 ... 4000, count: 4)

        let rules = workflows["in"]!
        let result = applyRule(0, of: rules, on: parts, workflows)

        return result
    }

    func applyRule(_ num: Int, of rules: [Rule], on parts: [ClosedRange<Int>], _ workflows: [String: [Rule]]) -> Int {
        var result = 0
        let rule = rules[num]

        let (nextWorkflow, partForNextWorkflow, partsForNextRule) = rule.apply(to: parts)

        if !partsForNextRule.allSatisfy({ $0.isEmpty }) {
            result += applyRule(num + 1, of: rules, on: partsForNextRule, workflows)
        }

        if !partForNextWorkflow.allSatisfy({ $0.isEmpty }) {

            switch nextWorkflow {
            case "A":
                result += partForNextWorkflow.map(\.count).reduce(1, *)
            case "R":
                break
            default:
                let nextRules = workflows[nextWorkflow]!
                result += applyRule(0, of: nextRules, on: partForNextWorkflow, workflows)
            }
        }

        return result
    }
}

private extension ClosedRange where Bound == Int {
    var desc: String { "\(lowerBound)-\(upperBound)" }
}
