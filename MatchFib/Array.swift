//
//  Array.swift
//  MatchFib
//
//  Created by Donny Wals on 31/05/16.
//  Copyright © 2016 DonnyWals. All rights reserved.
//

import Foundation

extension Array where Element: GridPointType {
    func detectFibonacciSequences() -> [GridPointType] {
        var sequences = [GridPointType]()
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
                sequences += currentSequence
                currentSequence.removeAll()
            }
        }
        
        return sequences
    }
}