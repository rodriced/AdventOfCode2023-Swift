//
//  D02.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 04/12/2023.
//

final class D02: Day {
    let num = 2

    func puzzle1(_ input: Input) -> Int {

        var result = 0

        for line in input.stringLines {
            let gameParts = line.dropFirst(5).split(separator: ":")
            let gameNum = Int(gameParts[0])!

            let draws = gameParts[1].split(separator: ";")

            var valid = true

            for draw in draws {

                for cube in draw.split(separator: ",") {

                    let cubeInfos = cube.dropFirst(1).split(separator: " ")
                    let qt = Int(cubeInfos[0])!
                    let color = cubeInfos[1]

                    switch color {
                    case "red":
                        valid = valid && qt <= 12
                    case "green":
                        valid = valid && qt <= 13
                    case "blue":
                        valid = valid && qt <= 14
                    default:
                        fatalError("bad color \(color)")
                    }
                }
            }

            result += valid ? gameNum : 0
        }

        return result
    }

    func puzzle2(_ input: Input) -> Int {

        var result = 0

        for line in input.stringLines {
            let gameParts = line.split(separator: ":")

            let draws = gameParts[1].split(separator: ";")

            var red = 0
            var green = 0
            var blue = 0

            for draw in draws {

                for cube in draw.split(separator: ",") {

                    let cubeInfos = cube.dropFirst(1).split(separator: " ")
                    let qt = Int(cubeInfos[0])!
                    let color = cubeInfos[1]

                    switch color {
                    case "red":
                        red = max(red, qt)
                    case "green":
                        green = max(green, qt)
                    case "blue":
                        blue = max(blue, qt)
                    default:
                        fatalError("bad color \(color)")
                    }
                }
            }

            result += red * green * blue
        }

        return result
    }
}
