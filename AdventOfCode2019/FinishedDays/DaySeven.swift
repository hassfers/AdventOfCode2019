//
//  DaySeven.swift
//  AdventOfCode2019
//
//  Created by Stefan Haßferter on 16.12.19.
//  Copyright © 2019 Stefan Haßferter. All rights reserved.
//

import Foundation
func DaySeven(){
    //    let initialMemory = [3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5]
    var allCases = [[Int]]()
    
    func permuteWirth(_ a: [Int], _ n: Int)  {
        if n == 0 {
            print(a)
            allCases.append(a)// display the current permutation
        } else {
            var a = a
            permuteWirth(a, n - 1)
            for i in 0..<n {
                a.swapAt(i, n)
                permuteWirth(a, n - 1)
                a.swapAt(i, n)
            }
        }
    }
    let initialMemory = [3,8,1001,8,10,8,105,1,0,0,21,34,51,64,73,98,179,260,341,422,99999,3,9,102,4,9,9,1001,9,4,9,4,9,99,3,9,1001,9,4,9,1002,9,3,9,1001,9,5,9,4,9,99,3,9,101,5,9,9,102,5,9,9,4,9,99,3,9,101,5,9,9,4,9,99,3,9,1002,9,5,9,1001,9,3,9,102,2,9,9,101,5,9,9,1002,9,2,9,4,9,99,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,99,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,99]
    
    //part One
    //    let computer = IntCode(data: initialMemory)
    //    computer.inputAutomaticMode = true
    
    //    permuteWirth([0,1,2,4,3], [0,1,2,4,3].count - 1)
    //
    //    allCases.forEach { (input) in
    //        print("----- routine \(input)")
    //        //prepare computer
    //        computer.inputBuffer = input
    //        //insert last output to buffer for loop
    //        computer.inputBuffer.insert(computer.lastOutput, at: 1)
    //        //Amps
    //        for index in 0...4{
    //            print("\(index) opamp")
    //            computer.run()
    //            computer.data = initialMemory
    //        }
    //        //reset pc input counter
    //        computer.inputCounter = 0
    //    }
    
    
    
    //part Two
    permuteWirth([5,6,7,8,9], [5,6,7,8,9].count - 1)
    
    var outputs = [Int]()
    allCases.forEach { (input) in
        //generate clean Amps
        let amps = (0...4).map{ index in
               IntCode(data: initialMemory)
        }
        amps.map{
              $0.inputAutomaticMode = true
          }

        
        while !amps.last!.isFinished {
            for index in 0 ..< amps.count{
                var currentAmp = amps[index]
                print("\n-----------")
                print("currentAmp: \(index)")
                
                if currentAmp.initial{
                    currentAmp.inputBuffer = [input[index], index == 0 ? amps.last!.lastOutput : amps[index - 1].lastOutput]
                    currentAmp.initial = false
                    currentAmp.inputCounter = 0
                    currentAmp.run()
                } else {
                    currentAmp.inputBuffer = [ index > 0 ? amps[index - 1].lastOutput : amps.last!.lastOutput]
                    currentAmp.inputCounter = 0
                    currentAmp.resume()
                }
            }
        }
        outputs.append(amps.last!.lastOutput)
    }
    
    print(outputs.max())
}


