//
//  SequenceType.swift
//  MatchFib
//
//  Created by Donny Wals on 31/05/16.
//  Copyright © 2016 DonnyWals. All rights reserved.
//

import Foundation

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