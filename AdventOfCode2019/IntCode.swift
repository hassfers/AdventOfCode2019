//
//  IntCode.swift
//  AdventOfCode2019
//
//  Created by Stefan Haßferter on 12.12.19.
//  Copyright © 2019 Stefan Haßferter. All rights reserved.
//

class IntCode{
    enum Commands: Int{
        case add = 1
        case multiply = 2
        case finised = 99
    }
    
    var data: [Int]
    var commands =  [[Int]]()
    
    init(data:[Int]){
        self.data = data
        parseCommands()
    }
    
    func run(){
        for index in 0..<commands.count{
            if runCommandSet(set: commands[index]){
                return
            }
        }
    }
    
    func runCommandSet(set:[Int])-> Bool {
        switch Commands.init(rawValue: set[0]) {
        case .add:
            data[set[3]] = data[set[1]] + data[set[2]]
        case .multiply:
            data[set[3]] = data[set[1]] * data[set[2]]
        case .finised:
            return true
        default:
            fatalError()
        }
        parseCommands()
        return false
    }
    
    func parseCommands(){
        commands = data.chunked(into: 4)
        print(commands)
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
