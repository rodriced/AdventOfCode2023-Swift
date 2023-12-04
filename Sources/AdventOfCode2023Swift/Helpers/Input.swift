//
//  Input.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 03/12/2023.
//

import Foundation

final class Input {
    enum Kind {
        case prod(Int)
        case test(String)
    }

    let kind: Kind

    init(_ kind: Kind) {
        self.kind = kind
    }

    static func inputFileUrl(day: Int) -> URL {
        guard (1 ... 25).contains(day) else {
            fatalError("Bad value for day : \(day). It must be between 1 and 25.")
        }

        let fn = String(format: "D%02d", day)
        guard let url = Bundle.module.url(forResource: fn, withExtension: "txt", subdirectory: "Inputs")
        else {
            fatalError("Couldn't find \(fn).txt in resources.")
        }

        return url
    }

    var string: String {
        switch self.kind {
        case let .prod(day):
            let url = Self.inputFileUrl(day: day)
            do {
                return try String(contentsOf: url)
            } catch {
                fatalError("Cannot read file \(url)")
            }
        case let .test(string):
            return string
        }
    }

    
    var stringLines: [String.SubSequence] {
        return string
            .trimmingCharacters(in: .newlines)
            .split(separator: "\n", omittingEmptySubsequences: false)
    }

    var data: Data {
        switch self.kind {
        case let .prod(day):
            let url = Self.inputFileUrl(day: day)
            do {
                return try Data(contentsOf: url)
            } catch {
                fatalError("Cannot read file \(url)")
            }
        case let .test(string):
            return Data(string.utf8)
        }
    }
    
    var dataLines: [Data.SubSequence] {
        data
            .split(separator: Character("\n").asciiValue!)
    }
}
