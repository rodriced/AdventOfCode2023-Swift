//
//  D17.swift
//  AdventOfCode2023Swift
//
//  Created by Rodolphe Desruelles on 20/12/2023.
//

final class D17: Day {
    let num = 17

    final class Grid<T> {
        private(set) var elts: [[T]]

        lazy var size = XY(elts[0].count, elts.count)
        lazy var limit = XY(elts[0].count - 1, elts.count - 1)

        init(_ elts: [[T]]) {
            self.elts = elts
        }

        convenience init(size: XY, elt: T) {
            self.init(
                Array(
                    repeating: Array(repeating: elt, count: size.x),
                    count: size.y
                )
            )
        }

        subscript(_ p: XY) -> T {
            get {
                elts[p.y][p.x]
            }
            set(elt) {
                elts[p.y][p.x] = elt
            }
        }
    }

    struct Node: Comparable {
        static func < (lhs: D17.Node, rhs: D17.Node) -> Bool {
            lhs.totalLoss < rhs.totalLoss
        }

        let xy: XY
        var totalLoss: Int
        let prevXY: XY

        struct Key: Hashable {
            let xy: XY
            let prevXY: XY

            init(_ xy: XY, _ prevXY: XY) {
                self.xy = xy
                self.prevXY = prevXY
            }
        }

        var key: Key { Key(xy, prevXY) }
    }

//    func printQueue(_ nodes: [Node]) {
//        let q = nodes.filter { $0.totalLoss < Int.max }
//
//        print(q.map { "\($0.xy)\($0.totalLoss)"})
//    }

    func puzzle1(_ input: Input) -> Int {
        let heatLosses = input.dataLines.map { $0.map { Int($0 - Character("0").asciiValue!) } }
        let heatLossesGrid = Grid(heatLosses)

        let xyMax = heatLossesGrid.limit

        let initial = XY(0, 0)
        let end = heatLossesGrid.limit

        var nodes: [Node.Key: Node] = [:]

        let initialNode = Node(xy: initial, totalLoss: 0, prevXY: initial)
        nodes[initialNode.key] = initialNode

        for (y, line) in heatLosses.enumerated() {
            for x in line.indices {
                let xy = XY(x, y)

                guard xy != initial else {
                    continue
                }

                for delta in XY.adjacentDeltas {
                    for step in 1 ... 3 {
                        let prevXY = xy + step * delta

                        guard !prevXY.isOutside(limit: xyMax) else {
                            continue
                        }
                        let node = Node(xy: xy, totalLoss: Int.max, prevXY: prevXY)
                        nodes[node.key] = node
                    }
                }
            }
        }

        var prevs: [Node.Key: Node.Key] = [:]
        var result = 0

        while true {
            guard let (origineKey, origin) = (nodes
                .min { $0.value.totalLoss < $1.value.totalLoss })
            else {
                break
            }

            nodes.removeValue(forKey: origineKey)

//            printQueues(Array(nodes.values))

            if origin.xy == end {
                result = origin.totalLoss
                break
            }

            let prevXY = origin.xy == origin.prevXY ? nil : origin.prevXY

            for adjDelta in origin.xy.adjacentOrthogonalDeltas(prev: prevXY) {

                var adjXY = origin.xy
                var adjHeatLossSum = 0

                var straightCount = 0

                while straightCount < 3 {
                    straightCount += 1
                    adjXY += adjDelta

                    guard !adjXY.isOutside(limit: xyMax) && adjXY != initial else {
                        break
                    }

                    let adjKey = Node.Key(adjXY, origin.xy)

                    adjHeatLossSum += heatLossesGrid[adjXY]

                    if let adj = nodes[adjKey] {
                        let newAdjTotalLoss = origin.totalLoss + adjHeatLossSum

                        if newAdjTotalLoss < adj.totalLoss {
                            var newAdj = adj
                            newAdj.totalLoss = newAdjTotalLoss
                            nodes[adj.key] = newAdj

                            prevs[adj.key] = origin.key
                        }

                    }
                }
            }
        }

        return result
    }
    
    func puzzle2(_ input: Input) -> Int {
        let heatLosses = input.dataLines.map { $0.map { Int($0 - Character("0").asciiValue!) } }
        let heatLossesGrid = Grid(heatLosses)

        let xyMax = heatLossesGrid.limit

        let initial = XY(0, 0)
        let end = heatLossesGrid.limit

        var nodes: [Node.Key: Node] = [:]

        let initialNode = Node(xy: initial, totalLoss: 0, prevXY: initial)
        nodes[initialNode.key] = initialNode

        for (y, line) in heatLosses.enumerated() {
            for (x, _) in line.enumerated() {
                let xy = XY(x, y)

                for delta in XY.adjacentDeltas {
                    for step in 4 ... 10 {
                        let prevXY = xy + step * delta

                        guard !prevXY.isOutside(limit: xyMax) else {
                            break
                        }

                        let node = Node(xy: xy, totalLoss: Int.max, prevXY: prevXY)
                        nodes[node.key] = node
                    }
                }
            }
        }

        var prevs: [Node.Key: Node.Key] = [:]
        var result = 0

        while true {
            guard let (originKey, origin) = (nodes
                .min { $0.value.totalLoss < $1.value.totalLoss })
            else {
                break
            }

//            printQueue(Array(nodes.values))

            nodes.removeValue(forKey: originKey)

            if origin.xy == end {
                result = origin.totalLoss
                break
            }

            let prevXY = origin.xy == origin.prevXY ? nil : origin.prevXY

            for adjDelta in origin.xy.adjacentOrthogonalDeltas(prev: prevXY) {

                var adjXY = origin.xy
                var adjHeatLossSum = 0

                var straightCount = 0

                while straightCount < 10 {
                    straightCount += 1
                    adjXY += adjDelta

                    guard !adjXY.isOutside(limit: xyMax) && adjXY != initial else {
                        break
                    }

                    adjHeatLossSum += heatLossesGrid[adjXY]

                    guard straightCount >= 4 else {
                        continue
                    }

                    let adjKey = Node.Key(adjXY, origin.xy)

                    if let adj = nodes[adjKey] {
                        let newAdjTotalLoss = origin.totalLoss + adjHeatLossSum

                        if newAdjTotalLoss < adj.totalLoss {
                            var newAdj = adj
                            newAdj.totalLoss = newAdjTotalLoss
                            nodes[adj.key] = newAdj

                            prevs[adj.key] = origin.key
                        }

                    }
                }
            }
        }

        return result
    }
}
