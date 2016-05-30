//
//  Grid.swift
//  MatchFib
//
//  Created by Donny Wals on 30/05/16.
//  Copyright © 2016 DonnyWals. All rights reserved.
//

import UIKit

struct Grid {
    var pointMatrix: [[GridPoint]]
    
    var points: [GridPoint] {
        return pointMatrix.points
    }
    
    var rows: Int {
        return pointMatrix.count
    }
    
    var columns: Int {
        guard pointMatrix.count > 0 else { return 0 }

        return pointMatrix[0].count
    }
    
    init(rows: Int, columns: Int) {
        var matrix = [[GridPoint]]()
        for row in 0..<rows {
            var points = [GridPoint]()
            
            for column in 0..<columns {
                points.append(GridPoint(x: column, y: row, value: 0, blinkStyle: .None))
            }
            
            matrix.append(points)
        }
        
        self.pointMatrix = matrix
    }
    
    func pointsInRow(row: Int) -> [GridPoint] {
        return pointMatrix.pointsInRow(row)
    }
    
    func pointsInColumn(column: Int) -> [GridPoint] {
        return pointMatrix.pointsInColumn(column)
    }
    
    mutating func incrementFromPoint(coords: CGPoint) {
        let x = Int(coords.x)
        let y = Int(coords.y)
        
        // increment the affected points
        var tmpMatrix: [[GridPoint]] = pointMatrix.map { row in
            row.map { point in
                if point.x == x || point.y == y {
                    return GridPoint(x: point.x, y: point.y, value: point.value+1, blinkStyle: .Update)
                }
                
                return point
            }
        }
        
        var fibonacciPoints = Set<GridPoint>()
        
        // find fibonaccis on the x axis
        for row in 0..<rows {
            for point in tmpMatrix.pointsInRow(row).detectFibonacciSequences() {
                fibonacciPoints.insert(GridPoint(x: point.x, y: point.y, value: 0, blinkStyle: .Reset))
            }
        }
        
        // find fibonaccis on the y axis
        for column in 0..<columns {
            for point in tmpMatrix.pointsInColumn(column).detectFibonacciSequences() {
                fibonacciPoints.insert(GridPoint(x: point.x, y: point.y, value: 0, blinkStyle: .Reset))
            }
        }
        
        // updated the tmpMatrix with discovered fibonaccis
        for point in fibonacciPoints {
            tmpMatrix[point.y][point.x] = point
        }
        
        // update the pointMatrix
        pointMatrix = tmpMatrix
    }
}

extension Array where Element: GridPointType {
    func detectFibonacciSequences() -> [GridPointType] {
        var sequences = [[GridPointType]]()
        for (i, point) in self.enumerate() {
            let fibonacci = point.value.fibonacci
            
            if let fibIndex = fibonacci.index where fibonacci.found {
                var fibSequence: [GridPointType] = [point]
                
                var curFibIndex = fibIndex
                var currentValueIsFib = true
                var curPointIndex = i
                
                while currentValueIsFib && fibSequence.count < 5 {
                    curPointIndex = curPointIndex.successor()
                    
                    guard curPointIndex < self.count else { break }
                    
                    let p = self[curPointIndex]
                    
                    let fibonacci = p.value.fibonacci
                    var realIndex = fibonacci.index
                    if curFibIndex == 0 && realIndex == 2 { realIndex = 1 }
                    
                    if let idx = realIndex where fibonacci.found && idx == curFibIndex + 1 {
                        curFibIndex = idx
                        currentValueIsFib = true
                        fibSequence.append(p)
                    } else {
                        currentValueIsFib = false
                    }
                }
                
                if fibSequence.count == 5 {
                    sequences.append(fibSequence)
                }
            }
        }
        
        return sequences.flatMap { $0 }
    }
}

extension Int {
    /*
     * Implementation translated from: http://stackoverflow.com/a/2822801/1522128
     */
    var fibonacci: (found: Bool, index: Int?) {
        let root5: Double = sqrt(5)
        let goldenratio = (1 + root5) / 2
        
        let idx = floor(log(Double(self) * root5) / log(goldenratio) + 0.5)
        let u = floor(pow(goldenratio, idx)/root5 + 0.5)
        
        if Int(u) != self {
            return (false, nil)
        }
        
        return (true, idx.isFinite ? Int(idx) : 0)
    }
}

extension SequenceType where Generator.Element == [GridPoint] {
    var points: Generator.Element {
        return self.flatMap {$0}
    }
    
    func pointsInRow(row: Int) -> Generator.Element {
        return self.points.filter { $0.y == row }
    }
    
    func pointsInColumn(column: Int) -> Generator.Element {
        return self.points.filter { $0.x == column }
    }
}