//
//  D20.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 27/12/2023.
//

import Algorithms

typealias Pulse = (val: Bool, dest: Int, src: Int)

private protocol Module {
    var ref: Int { get }
    var dests: [Int] { get }
    mutating func processPulse(_ pulse: Pulse) -> Bool?
}

private struct FlipFlop: Module {

    let ref: Int
    let dests: [Int]

    var enabled: Bool = false

    mutating func processPulse(_ pulse: Pulse) -> Bool? {
        guard pulse.val == false else { return nil }

        enabled = !enabled
        return enabled
    }
}

private struct Conjunction: Module {
    let ref: Int
    let dests: [Int]

    var entries: [Int: Bool] = [:]
    var lastOutput = true

    mutating func setupEntries(with srcs: [Int]) {
        for src in srcs {
            entries[src] = false
        }
    }

    mutating func processPulse(_ pulse: Pulse) -> Bool? {
        entries[pulse.src] = pulse.val
        lastOutput = !entries.values.allSatisfy { $0 == true }
        return lastOutput
    }
}

final class D20: Day {
    let num = 20

    fileprivate func parseInput(_ input: Input) -> ([Int], [Module], [String: Int]) {
        var broadcasterDests: [Int] = []
        var refs: [String: Int] = ["output": -1, "rx": -1]
        var modules: [Module] = []

        for (n, line) in input.stringLines.filter({ $0.first! != "b" }).enumerated() {
            let mod = line.split(separator: " -> ")[0].dropFirst()
            refs[String(mod)] = n
        }

        for line in input.stringLines {
            let parts = line.split(separator: " -> ")
            let destsStr = parts[1].split(separator: ", ").map(String.init)
            let dests = destsStr.map { refs[$0]! }

            if parts[0] == "broadcaster" {
                broadcasterDests = dests
            } else {
                let kind = parts[0].first!
                let ref = refs[String(parts[0].dropFirst())]!

                let module: Module = kind == "%" ?
                    FlipFlop(ref: ref, dests: dests) : Conjunction(ref: ref, dests: dests)
                modules.append(module)
            }
        }

        for var module in modules.compactMap({ $0 as? Conjunction }) {
            let srcs = modules.filter {
                $0.dests.contains(module.ref)
            }
            .map(\.ref)
            module.setupEntries(with: srcs)
            modules[module.ref] = module
        }

        return (broadcasterDests, modules, refs)
    }

    func printPulses(_ pulses: [Pulse]) {
        pulses.forEach {
            print($0.src, $0.val ? "-high->" : "-low->", $0.dest)
        }
    }

    func puzzle1(_ input: Input) -> Int {
        var (broadcasterDests, modules, _) = parseInput(input)

        var result = [0, 0]

        for _ in 1 ... 1000 {
            result[0] += 1
            var pulses = broadcasterDests.map { (val: false, dest: $0, src: -10) }

            while !pulses.isEmpty {

                let pulsesCount = {
                    let tmp = pulses.partitioned { $0.val }
                    return [tmp.0, tmp.1].map { $0.count }
                }()
                result = zip(result, pulsesCount).map { $0 + $1 }

                var nextPulses: [Pulse] = []

                for pulse in pulses.filter({ $0.dest != -1 }) {
                    var module = modules[pulse.dest]

                    let outVal = module.processPulse(pulse)
                    modules[pulse.dest] = module

                    guard let outVal else {
                        continue
                    }

                    for dest in module.dests {
                        nextPulses.append((val: outVal, dest: dest, src: module.ref))
                    }
                }

                pulses = nextPulses
            }
        }
        return result[0] * result[1]
    }

    func puzzle2(_ input: Input) -> Int {
        var (broadcasterDests, modules, refs) = parseInput(input)

        let finalDest = refs["rx"]!
        let intermediateDests = ["rl", "nn", "qb", "rd"].map { refs[$0]! }
        var intermediateCycles = Array(repeating: 0, count: 4)

        var cyclesCount = 0

        while true {
            cyclesCount += 1

            var pulses = broadcasterDests.map { (val: false, dest: $0, src: -10) }

            while !pulses.isEmpty {
                var nextPulses: [Pulse] = []

                for pulse in pulses {
                    guard pulse.dest != finalDest else {
                        continue
                    }

                    var module = modules[pulse.dest]

                    let outVal = module.processPulse(pulse)
                    modules[pulse.dest] = module

                    guard let outVal else {
                        continue
                    }

                    if let i = intermediateDests.firstIndex(of: module.ref) {
                        if (module as! Conjunction).lastOutput == false {
                            intermediateCycles[i] = cyclesCount
                        }
                    }

                    for dest in module.dests {
                        nextPulses.append((val: outVal, dest: dest, src: module.ref))
                    }
                }

                pulses = nextPulses
            }

            if intermediateCycles.allSatisfy({ $0 > 0 }) {
                break
            }
        }

        return Math.findLeastCommonMultiple(intermediateCycles)
    }
}
