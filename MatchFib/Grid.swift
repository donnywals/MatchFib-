//
//  Grid.swift
//  MatchFib
//
//  Created by Donny Wals on 30/05/16.
//  Copyright © 2016 DonnyWals. All rights reserved.
//

import UIKit

struct GridPoint {
    let x: Int
    let y: Int
    let value: Int
}

struct Grid {
    let pointMatrix: [[GridPoint]]
    
    var points: [GridPoint] {
        return pointMatrix.flatMap { $0 }
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
                points.append(GridPoint(x: row, y: column, value: 0))
            }
            
            matrix.append(points)
        }
        
        self.pointMatrix = matrix
    }
}