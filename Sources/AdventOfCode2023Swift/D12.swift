//
//  D12.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 12/12/2023.
//

final class D12: Day {
    let num = 12

    typealias Spring = ([Character], [Int])

    struct Key: Hashable {
        let sy: Int
        let si: Int

        init(_ sy: Int, _ si: Int) {
            self.sy = sy
            self.si = si
        }
    }

    func puzzle1(_ input: Input) -> Int {
        let springsParts = input.stringLines.map {
            let parts = $0.split(separator: " ")

            let symbols = parts[0]
            let sizes = parts[1]

            return [symbols, sizes]
        }

        return puzzleCommon(springsParts)
    }

    func puzzle2(_ input: Input) -> Int {
        let springsParts = input.stringLines.map {
            let parts = $0.split(separator: " ")

            let symbols = Array(repeating: parts[0], count: 5)
                .joined(separator: "?")
                .trimming { $0 == "." }

            let sizes = Array(repeating: parts[1], count: 5).joined(separator: ",")[...]

            return [symbols, sizes]
        }

        return puzzleCommon(springsParts)
    }

    func puzzleCommon(_ springsParts: [[Substring]]) -> Int {
        let springs = springsParts.map { parts in
            let symbols = parts[0]
                .trimming { $0 == "." }
                .map { $0 }

            let sizes = parts[1].split(separator: ",").map {
                Int($0)!
            }

            var cleanedSymbols = [symbols[0]]

            var prevChar = cleanedSymbols[0]
            for char in symbols.dropFirst() {
                if prevChar == "." && char == "." {
                    continue
                }

                cleanedSymbols.append(char)
                prevChar = char
            }

            return (cleanedSymbols, sizes)
        }

        var result = 0

        for spring in springs {
            var cache: [Key: Int] = [:]

            result += nbOfValidSolution(spring, cache: &cache)
        }

        return result
    }

    func isPatternValid(at pos: Int, size: Int, in symbols: [Character]) -> Bool {
        guard pos + size <= symbols.count else {
            return false
        }

        let result = (pos + size == symbols.count || symbols[pos + size] == "." || symbols[pos + size] == "?")
            && symbols[pos ..< pos + size].allSatisfy { $0 == "#" || $0 == "?" }

        return result
    }

    func nbOfValidSolution(symbolsIndex: Int = 0, sizeIndex: Int = 0, _ spring: Spring, cache: inout [Key: Int]) -> Int {

        let key = Key(symbolsIndex, sizeIndex)

        if let result = cache[key] {
            return result
        }

        let (symbols, sizes) = spring

        if sizeIndex > sizes.count - 1 {
            let result = symbolsIndex < symbols.count && symbols[symbolsIndex...].contains("#") ? 0 : 1

            cache[key] = result
            return result
        }

        var pos = symbolsIndex
        let size = sizes[sizeIndex]

        var result = 0

        while pos + size <= symbols.count {
            if isPatternValid(at: pos, size: size, in: symbols) {
                result += nbOfValidSolution(symbolsIndex: pos + size + 1, sizeIndex: sizeIndex + 1, spring, cache: &cache)
            }

            if symbols[pos] == "#" {
                break
            }

            pos += 1
        }

        cache[key] = result
        return result
    }
}
