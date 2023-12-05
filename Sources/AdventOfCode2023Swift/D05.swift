//
//  D05.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 05/12/2023.
//

final class D05: Day {
    let num = 5

    func puzzle1(_ input: Input) -> Int {
        let lines = input.stringLines

        var src = lines[0].split(separator: " ").dropFirst(1).map { Int($0)! }
        var dst = [Int]()

        var l = 3
        while l < lines.count {
            let line = lines[l].trimmingCharacters(in: .whitespaces)

            let nums = line.split(separator: " ").map { Int($0)! }
            let dstStart = nums[0]
            let srcStart = nums[1]
            let length = nums[2]

            let srcRange = (srcStart ... srcStart + length)
            let step = dstStart - srcStart

            var si = src.count - 1
            while si >= 0 {
                if srcRange.contains(src[si]) {
                    let srcVal = src.remove(at: si)
                    dst.append(srcVal + step)
                }

                si -= 1
            }

            l += 1

            if l == lines.count - 1 || lines[l].isEmpty {
                src.append(contentsOf: dst)
                dst = []
                l += 2
            }
        }

        return src.min()!
    }

    func puzzle2(_ input: Input) -> Int {
        let lines = input.stringLines

        let seedsInfos = lines[0].split(separator: " ").dropFirst(1).map { Int($0)! }
        var src = stride(from: 0, to: seedsInfos.count, by: 2)
            .map { i in
                seedsInfos[i] ... seedsInfos[i] + seedsInfos[i + 1] - 1
            }

        var dst = [ClosedRange<Int>]()

        var l = 3
        while l < lines.count {
            let line = lines[l].trimmingCharacters(in: .whitespaces)

            let nums = line.split(separator: " ").map { Int($0)! }
            let dstStart = nums[0]
            let srcStart = nums[1]
            let length = nums[2]

            let srcRangeFilter = (srcStart ... srcStart + length)
            let step = dstStart - srcStart

            var si = src.count - 1
            while si >= 0 {
                if srcRangeFilter.overlaps(src[si]) {
                    let srcRange = src.remove(at: si)
                    dst.append(srcRange.clamped(to: srcRangeFilter).translated(step: step))

                    if srcRange.lowerBound < srcRangeFilter.lowerBound {
                        src.append(srcRange.lowerBound ... srcRangeFilter.lowerBound - 1)
                    }

                    if srcRange.upperBound > srcRangeFilter.upperBound {
                        src.append(srcRangeFilter.upperBound + 1 ... srcRange.upperBound)
                    }
                }

                si -= 1
            }

            l += 1

            if l == lines.count - 1 || lines[l].isEmpty {
                src.append(contentsOf: dst)
                dst = []
                l += 2
            }
        }

        return src.map { $0.lowerBound }.min()!
    }

}

private extension ClosedRange where Bound: AdditiveArithmetic {
    func translated(step: Bound) -> Self {
        return lowerBound + step ... upperBound + step
    }
}
