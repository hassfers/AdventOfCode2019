//
//  DayFour.swift
//  AdventOfCode2019
//
//  Created by Stefan Haßferter on 15.12.19.
//  Copyright © 2019 Stefan Haßferter. All rights reserved.
//
import Foundation

func DayFour(){
    let min = 123257
    let max = 647015
    var passwords:[Int] = []
    print(111111.neverDecreases())
    print(123444.neverDecreases())
//    for i in min ... max {
//        if (i.neverDecreases() && i.hasTwoAdjacentDigits()) {
//            passwords.append(i)
//        }
//    }
    print(passwords.count)
}

extension Int{
    func hasTwoAdjacentDigits()-> Bool {
        let string = String(self)
        return string.contains("00")
            || string.contains("11")
            || string.contains("22")
            || string.contains("33")
            || string.contains("44")
            || string.contains("55")
            || string.contains("66")
            || string.contains("77")
            || string.contains("88")
            || string.contains("99")
    }
    
    func neverDecreases()->Bool{
        for i in (0...4) {
            if sixDigits()[i] > sixDigits()[i+1]{
                return false
            }
        }
        return true
    }
    
    func sixDigits() -> [Int] {
        var buffer = self
        var digits = [Int]()
        for i in 1...6 {
            digits.append(buffer % 10)
            buffer /= 10
        }
        return digits.reversed()
    }
}
