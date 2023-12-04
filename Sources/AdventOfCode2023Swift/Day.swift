//
//  Day.swift
//
//
//  Created by Rodolphe Desruelles on 02/12/2023.
//

protocol Day {
    var num: Int { get }
    func puzzle1(_ input: Input) -> Int
    func puzzle2(_ input: Input) -> Int

    func getParams() -> [String: Any]
}

extension Day {
    func getParams() -> [String: Any] { [:] }
}
