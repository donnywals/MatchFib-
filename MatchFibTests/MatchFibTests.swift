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
Na elke verandering licht een cel kort geel op.

Als 5 elkaar in de Fibonacci-reeks opvolgende getallen naast elkaar staan,
lichten deze cellen kort groen op en worden ze leeg gemaakt.
*/
    
    func createAndValidateGrid(rows rows: Int, columns: Int) -> Grid {
        let grid = Grid(rows: rows, columns: columns)
        XCTAssert(grid.rows == rows)
        XCTAssert(grid.columns == columns)
        return grid
    }
    
    func testGridGeneration() {
        createAndValidateGrid(rows: 50, columns: 50)
        createAndValidateGrid(rows: 20, columns: 20)
    }
    
    func testGridIncrement() {
        var grid = createAndValidateGrid(rows: 50, columns: 50)
        let tappingPoint = CGPointMake(2, 2)
        grid.incrementFromPoint(tappingPoint)
        for point in grid.points {
            if point.x == Int(tappingPoint.x) || point.y == Int(tappingPoint.y) {
                XCTAssert(point.value == 1)
            } else {
                XCTAssert(point.value == 0)
            }
        }
    }
    
    func valuesForRow(row: Int, grid: Grid) -> [Int] {
        return grid.pointsInRow(row).map { $0.value }
    }
    
    func testFibonacciRowDetection() {
        var grid = createAndValidateGrid(rows: 5, columns: 5)

        grid.incrementFromPoint(CGPointMake(1, 1))
        XCTAssert(valuesForRow(0, grid: grid) == [0, 1, 0, 0, 0])
        XCTAssert(valuesForRow(1, grid: grid) == [1, 1, 1, 1, 1])
        XCTAssert(valuesForRow(2, grid: grid) == [0, 1, 0, 0, 0])
        XCTAssert(valuesForRow(3, grid: grid) == [0, 1, 0, 0, 0])
        XCTAssert(valuesForRow(4, grid: grid) == [0, 1, 0, 0, 0])
        
        grid.incrementFromPoint(CGPointMake(2, 1))
        XCTAssert(valuesForRow(0, grid: grid) == [0, 1, 1, 0, 0])
        XCTAssert(valuesForRow(1, grid: grid) == [2, 2, 2, 2, 2])
        XCTAssert(valuesForRow(2, grid: grid) == [0, 1, 1, 0, 0])
        XCTAssert(valuesForRow(3, grid: grid) == [0, 1, 1, 0, 0])
        XCTAssert(valuesForRow(4, grid: grid) == [0, 1, 1, 0, 0])
        
        grid.incrementFromPoint(CGPointMake(3, 1))
        grid.incrementFromPoint(CGPointMake(3, 1))
        XCTAssert(valuesForRow(0, grid: grid) == [0, 1, 1, 2, 0])
        XCTAssert(valuesForRow(1, grid: grid) == [4, 4, 4, 4, 4])
        XCTAssert(valuesForRow(2, grid: grid) == [0, 1, 1, 2, 0])
        XCTAssert(valuesForRow(3, grid: grid) == [0, 1, 1, 2, 0])
        XCTAssert(valuesForRow(4, grid: grid) == [0, 1, 1, 2, 0])
        
        grid.incrementFromPoint(CGPointMake(4, 1))
        grid.incrementFromPoint(CGPointMake(4, 1))
        grid.incrementFromPoint(CGPointMake(4, 1))
        // fibonacci was detected, back to all 0
        XCTAssert(valuesForRow(0, grid: grid) == [0, 0, 0, 0, 0])
        XCTAssert(valuesForRow(1, grid: grid) == [7, 7, 7, 7, 7])
        XCTAssert(valuesForRow(2, grid: grid) == [0, 0, 0, 0, 0])
        XCTAssert(valuesForRow(3, grid: grid) == [0, 0, 0, 0, 0])
        XCTAssert(valuesForRow(4, grid: grid) == [0, 0, 0, 0, 0])
    }
    
    func testFibonacciColumnDetection() {
        var grid = createAndValidateGrid(rows: 5, columns: 2)
        
        grid.incrementFromPoint(CGPointMake(1, 1))
        XCTAssert(valuesForRow(0, grid: grid) == [0, 1, 0, 0, 0])
        XCTAssert(valuesForRow(1, grid: grid) == [1, 1, 1, 1, 1])
        XCTAssert(valuesForRow(2, grid: grid) == [0, 1, 0, 0, 0])
        XCTAssert(valuesForRow(3, grid: grid) == [0, 1, 0, 0, 0])
        XCTAssert(valuesForRow(4, grid: grid) == [0, 1, 0, 0, 0])
        
        grid.incrementFromPoint(CGPointMake(1, 2))
        XCTAssert(valuesForRow(0, grid: grid) == [0, 2, 0, 0, 0])
        XCTAssert(valuesForRow(1, grid: grid) == [1, 2, 1, 1, 1])
        XCTAssert(valuesForRow(2, grid: grid) == [1, 2, 1, 1, 1])
        XCTAssert(valuesForRow(3, grid: grid) == [0, 2, 0, 0, 0])
        XCTAssert(valuesForRow(4, grid: grid) == [0, 2, 0, 0, 0])
        
        grid.incrementFromPoint(CGPointMake(1, 3))
        grid.incrementFromPoint(CGPointMake(1, 3))
        XCTAssert(valuesForRow(0, grid: grid) == [0, 4, 0, 0, 0])
        XCTAssert(valuesForRow(1, grid: grid) == [1, 4, 1, 1, 1])
        XCTAssert(valuesForRow(2, grid: grid) == [1, 4, 1, 1, 1])
        XCTAssert(valuesForRow(3, grid: grid) == [2, 4, 2, 2, 2])
        XCTAssert(valuesForRow(4, grid: grid) == [0, 4, 0, 0, 0])
        
        grid.incrementFromPoint(CGPointMake(1, 4))
        grid.incrementFromPoint(CGPointMake(1, 4))
        grid.incrementFromPoint(CGPointMake(1, 4))
        // fibonacci was detected, back to all 0
        XCTAssert(valuesForRow(0, grid: grid) == [0, 7, 0, 0, 0])
        XCTAssert(valuesForRow(1, grid: grid) == [0, 7, 0, 0, 0])
        XCTAssert(valuesForRow(2, grid: grid) == [0, 7, 0, 0, 0])
        XCTAssert(valuesForRow(3, grid: grid) == [0, 7, 0, 0, 0])
        XCTAssert(valuesForRow(4, grid: grid) == [0, 7, 0, 0, 0])
    }
}
