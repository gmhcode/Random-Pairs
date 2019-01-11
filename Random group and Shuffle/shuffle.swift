//
//  shuffle.swift
//  Six Week Technical Challenge
//
//  Created by Greg Hughes on 1/11/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import Foundation

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffleButAllowed1() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffleButAllowed() -> [Element] {
        var result = Array(self)
        result.shuffleButAllowed1()
        return result
    }
}
