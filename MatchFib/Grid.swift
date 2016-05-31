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