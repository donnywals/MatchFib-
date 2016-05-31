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
                
                return GridPoint(x: point.x, y: point.y, value: point.value, blinkStyle: .None)
            }
        }
        
        var fibonacciPoints = [GridPoint]()
        
        // find fibonaccis on the x axis
        for row in 0..<rows {
            let found = tmpMatrix.pointsInRow(row).detectFibonacciSequences()
            for point in found {
                fibonacciPoints.append(GridPoint(x: point.x, y: point.y, value: 0, blinkStyle: .Reset))
            }
        }
        
        // find fibonaccis on the y axis
        for column in 0..<columns {
            for point in tmpMatrix.pointsInColumn(column).detectFibonacciSequences() {
                fibonacciPoints.append(GridPoint(x: point.x, y: point.y, value: 0, blinkStyle: .Reset))
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
        var currentSequence = [GridPointType]()
        
        for point in self {
            let fibonacci = point.value.fibonacci
            guard let fibIndex = fibonacci.index where fibonacci.found else {
                currentSequence.removeAll()
                continue
            }
            
            if let previousPoint = currentSequence.last, let previousFibIndex = previousPoint.value.fibonacci.index {
                // for the number 1 the index always returns 2.
                // so if the previous index was 0 (num 0)
                // and the current index is 2 (num 1)
                // we want to correct the index to 1
                // because logically the index for a 1 after a 0
                // should be 1 and not 2
                var correctedFibIndex = fibIndex
                if previousFibIndex == 0 && correctedFibIndex == 2 {
                    correctedFibIndex = 1
                }
                
                // if both current and previous value are 1
                // we need to make sure that either:
                // sequence count == 1 -> [1]
                // sequence count == 2 where sequence[0] == 0 -> [0, 1]
                let validIndexIncrement = previousFibIndex + 1 == correctedFibIndex
                let currentIndexEqualsPreviousIndex = correctedFibIndex == 2 && previousFibIndex == 2
                let validSequenceCountOne = currentSequence.count == 1 && currentSequence[0].value == 1
                let validSequenceCountTwo = currentSequence.count == 2 && currentSequence[0].value == 0

                if !validIndexIncrement &&
                    !(currentIndexEqualsPreviousIndex && (validSequenceCountOne || validSequenceCountTwo)) {
                    
                    // not a valid entry, we need to start a new sequence
                    currentSequence.removeAll()
                }
            }
            
            currentSequence.append(point)
            
            if currentSequence.count == 5 {
                sequences.append(currentSequence)
                currentSequence.removeAll()
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