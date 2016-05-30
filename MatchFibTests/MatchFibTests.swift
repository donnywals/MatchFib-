//
//  MatchFibTests.swift
//  MatchFibTests
//
//  Created by Donny Wals on 30/05/16.
//  Copyright © 2016 DonnyWals. All rights reserved.
//

import XCTest
@testable import MatchFib

class MatchFibTests: XCTestCase {
    
/*
 Maak een 50x50 grid. Als je klikt op een lege cel, worden alle cellen
 in de rij en kolom van de cel op 1 gezet. Is de cel niet leeg, dan
 wordt +1 gedaan. Na elke verandering licht een cel kort geel op. Als 5
 elkaar in de Fibonacci-reeks opvolgende getallen naast elkaar staan,
 lichten deze cellen kort groen op en worden ze leeg gemaakt.
*/
    
    func createGrid(rows rows: Int, columns: Int) -> Grid {
        return Grid(rows: rows, columns: columns)
    }
    
    func testGridGeneration() {
        let grid50 = createGrid(rows: 50, columns: 50)
        XCTAssert(grid50.rows == 50)
        XCTAssert(grid50.columns == 50)
        
        let grid20 = createGrid(rows: 20, columns: 20)
        XCTAssert(grid20.rows == 20)
        XCTAssert(grid20.columns == 20)
    }
    /*
    func testCellTap() {
        let grid = createGrid(rows: 50, columns: 50)
        let tappingPoint = CGPointMake(2, 2)
        grid.incrementFromPoint(tappingPoint)
        for point in grid.points {
            if point.x == tappingPoint.x || point.y == tappingPoint.y {
                XCTAssert(grid.valueForPoint(point) == 1)
            } else {
                XCTAssert(grid.valueForPoint(point) == 0)
            }
        }
    }
    */
}
