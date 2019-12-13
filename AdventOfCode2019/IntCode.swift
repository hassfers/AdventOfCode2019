//
//  IntCode.swift
//  AdventOfCode2019
//
//  Created by Stefan Haßferter on 12.12.19.
//  Copyright © 2019 Stefan Haßferter. All rights reserved.
//
//address = index of Array


class IntCode{
    enum Instruction: Int{
        case add = 1
        case multiply = 2
        case finished = 99
    }
    
    var data: [Int]
    
    init(data:[Int]){
        self.data = data
    }
    
    func run(){
        startCommands(from: 0)
    }
    
    func startCommands(from startposition: Int) {
        var stackpointer = startposition
        while data[stackpointer] != 99 {
            switch Instruction.init(rawValue: data[stackpointer]) {
            case .add:
                data[data[stackpointer + 3]] = data[data[stackpointer + 1]] + data[data[stackpointer + 2]]
                stackpointer += 4
            case .multiply:
                data[data[stackpointer + 3]] = data[data[stackpointer + 1]] * data[data[stackpointer + 2]]
                stackpointer += 4
            case .finished:
                break
            default:
                fatalError()
                break
            }
        }
    }
    
    var output:Int{
        return data[0]
    }
    func set(at position: Int, value:Int){
        data[position] = value
    }
}
