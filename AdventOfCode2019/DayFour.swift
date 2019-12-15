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
    for i in min ... max {
        if (i.neverDecreases() && i.hasTwoAdjacentDigits()) {
            passwords.append(i)
        }
    }
    print(passwords.count)
}

extension Int{
    func hasTwoAdjacentDigits()-> Bool {
        let doubles = [0,1,2,3,4,5,6,7,8,9]
        let digits = self.sixDigits()
        var value = false
        doubles.forEach { double in
            if (digits.filter {
                $0 == double
            }.count == 2){
                value = true
            }
        }
        return value
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
