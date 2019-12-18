//
//  DayEight.swift
//  AdventOfCode2019
//
//  Created by Stefan Haßferter on 18.12.19.
//  Copyright © 2019 Stefan Haßferter. All rights reserved.
//

import Foundation
func DayEight(){
    let string = Array(imageString)
    let layers = string.chunked(into: 150)
    var counts = [Int]()
    
    func findNumberOf(digits: String.Element,in array:[String.Element]) -> Int{
        array.filter { (c) -> Bool in
            c == digits
        }.count
    }
    
    for i in 0 ..< layers.count{
        counts.append(findNumberOf(digits: "0", in: layers[i]))
    }
    
    let layerWithLowest = layers[counts.firstIndex(of: counts.min() ?? 0)!]
    
    print(findNumberOf(digits: "1", in: layerWithLowest) * findNumberOf(digits: "2", in: layerWithLowest) )
    
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
