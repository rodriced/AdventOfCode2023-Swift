//
//  D15.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 17/12/2023.
//

final class D15: Day {
    let num = 15

    static func hash(_ s: Substring.UTF8View) -> Int {
        s.reduce(0) { partial, ascii in
            var current = partial + Int(ascii)
            current *= 17
            current %= 256
            return current
        }
    }

    func puzzle1(_ input: Input) -> Int {
        let steps = input.string
            .filter { $0 != Character("\n") }
            .split(separator: Character(","))
            .map { $0.utf8 }

        let result = steps.reduce(0) { partial, step in
            let h = Self.hash(step)
            return partial + h
        }

        return result
    }

    struct Step {
        enum Ope {
            case dash
            case equal(Int)
        }

        let label: Substring
        let box: Int
        let ope: Ope

        init(_ s: Substring) {
            let last = s.last!

            switch last {
            case "-": ope = .dash
                label = s.dropLast()
            default:
                ope = .equal(Int(String(last))!)
                label = s.dropLast(2)
            }

            box = hash(label.utf8)
        }
    }

    struct Lens {
        let label: String
        let val: Int
    }

    func puzzle2(_ input: Input) -> Int {
        let steps = input.string
            .filter { $0 != Character("\n") }
            .split(separator: Character(","))
            .map(Step.init)

        var boxes = Array(repeating: [Lens](), count: 256)

        for step in steps {
            switch step.ope {
            case .dash:
                boxes[step.box].removeAll { $0.label == step.label }
            case let .equal(l):
                if let i = boxes[step.box].firstIndex(where: { $0.label == step.label }) {
                    boxes[step.box][i] = Lens(label: String(step.label), val: l)
                } else {
                    boxes[step.box].append(Lens(label: String(step.label), val: l))
                }
            }
        }

        let result = boxes.enumerated().reduce(0) { partial, box in
            partial + box.element.enumerated().reduce(0) { partial2, lens in
                partial2 + (box.offset + 1) * (lens.offset + 1) * lens.element.val
            }
        }

        return result
    }

}
