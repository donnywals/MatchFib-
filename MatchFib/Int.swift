//
//  Int.swift
//  MatchFib
//
//  Created by Donny Wals on 31/05/16.
//  Copyright © 2016 DonnyWals. All rights reserved.
//

import Foundation

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