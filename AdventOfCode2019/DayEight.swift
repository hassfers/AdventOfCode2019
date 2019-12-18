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
    //    let string = Array("0222112222120000")
    let layers = string.chunked(into: 150)
    var counts = [Int]()
    
    func findNumberOf(digits: String.Element,in array:[String.Element]) -> Int{
        array.filter { (c) -> Bool in
            c == digits
        }.count
    }
    
    //    for i in 0 ..< layers.count{
    //        counts.append(findNumberOf(digits: "0", in: layers[i]))
    //    }
    //
    //    let layerWithLowest = layers[counts.firstIndex(of: counts.min() ?? 0)!]
    //
    //    print(findNumberOf(digits: "1", in: layerWithLowest) * findNumberOf(digits: "2", in: layerWithLowest) )
    var fixedPixels = [Int]()
    var resultLayer = [(index:Int,color:String.Element)]()
    for i in 0 ..< layers.count{
        for j in 0 ..< layers[i].count{
            let pixelNumber = j
            if layers[i][j] != "2" && !fixedPixels.contains(pixelNumber){
//                print("\(pixelNumber) = \(layers[i][j])")
                resultLayer.append((index: pixelNumber, color:layers[i][j]))
                fixedPixels.append(pixelNumber)
            }
        }
    }
    resultLayer.sort { (first, second) -> Bool in
        first.index < second.index
    }
    
    var resultString = resultLayer.map{
        $0.color
    }

    print()
    resultString.insert("\n", at: 25)
    resultString.insert("\n", at: 51)
    resultString.insert("\n", at: 77)
    resultString.insert("\n", at: 103)
    resultString.insert("\n", at: 129)
    resultString.append("\n")
    print("\(String(resultString).replacingOccurrences(of: "0", with: "◼️").replacingOccurrences(of: "1", with: "◻️"))")
    
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
