//
//  GridPoint.swift
//  MatchFib
//
//  Created by Donny Wals on 30/05/16.
//  Copyright © 2016 DonnyWals. All rights reserved.
//

import Foundation

protocol GridPointType {
    var x: Int { get }
    var y: Int { get }
    var value: Int { get }
}

struct GridPoint: GridPointType, Hashable {
    let x: Int
    let y: Int
    let value: Int
    
    var hashValue: Int {
        return Int("\(x)\(y)") ?? 0
    }
}

func ==(lhs: GridPoint, rhs: GridPoint) -> Bool {
    return lhs.x == rhs.x && lhs.y == lhs.x
}