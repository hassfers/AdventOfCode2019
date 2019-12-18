//
//  IntCode.swift
//  AdventOfCode2019
//
//  Created by Stefan Haßferter on 12.12.19.
//  Copyright © 2019 Stefan Haßferter. All rights reserved.
//
//address = index of Array


class IntCode{
    
    
    var data: [Int]
    var inputBuffer: [Int] = []
    var outputBuffer: [Int] = []
    var inputCounter = 0
    var inputAutomaticMode = false
    
    init(data:[Int]){
        self.data = data
    }
    
    func run(){
        startCommands(from: 0)
    }
    
    func startCommands(from startPosition: Int) {
        var stackPointer = startPosition
        var operationPointer = 2
        while data[stackPointer] != 99 && stackPointer < data.count {
            let opcodes = parseOpCode(data[stackPointer])
            
            switch Instruction.init(rawValue: opcodes[0]) {
            case .add:
                let value1 = getValue(for: stackPointer + 1, instruction: operationPointer, in: opcodes)
                operationPointer += 1
                let value2 = getValue(for: stackPointer + 2, instruction: operationPointer, in: opcodes)
                data[data[stackPointer + 3]] = value1 + value2
                operationPointer = 2
                stackPointer += 4
            case .multiply:
                let value1 = getValue(for: stackPointer + 1, instruction: operationPointer, in: opcodes)
                operationPointer += 1
                let value2 = getValue(for: stackPointer + 2, instruction: operationPointer, in: opcodes)
                data[data[stackPointer + 3]] = value1 * value2
                stackPointer += 4
                operationPointer = 2
            case .input:
                var input:Int
                if inputAutomaticMode {
                    input = inputBuffer[inputCounter]
                    print("AutomaticMode: Input = \(input) Counter=\(inputCounter)")
                    inputCounter += 1
                } else {
                    print("please enter Integer")
                    guard let stringInput = readLine(),
                        let int = Int(stringInput) else { fatalError("only Ints Supported") }
                    input = int
                }
                data[data[stackPointer + 1]] = input
                stackPointer += 2
                break
            case .output:
                print()
                let output = getValue(for: stackPointer + 1, instruction: operationPointer, in: opcodes)
                if inputCounter + 1 < inputBuffer.count{
                    inputBuffer.insert(output, at: inputCounter + 1)
                } else {
                    inputBuffer.append(output)
                }
                outputBuffer.append(output)
                print("output: \(output)")
                stackPointer += 2
                break
            case .jumpIfTrue:
                let value1 = getValue(for: stackPointer + 1, instruction: operationPointer, in: opcodes)
                operationPointer += 1
                let value2 = getValue(for: stackPointer + 2, instruction: operationPointer, in: opcodes)
                if value1 != 0 {
                    //do not increase stackPointer
                    stackPointer = value2
                } else {
                    stackPointer += 3
                }
                operationPointer = 2
                
            case .jumpIfFalse:
                let value1 = getValue(for: stackPointer + 1, instruction: operationPointer, in: opcodes)
                operationPointer += 1
                let value2 = getValue(for: stackPointer + 2, instruction: operationPointer, in: opcodes)
                if value1 == 0 {
                    //do not increase stackPointer
                    stackPointer = value2
                } else {
                    stackPointer += 3
                }
                operationPointer = 2
            //do not increase stackPointer
            case .lessThen:
                let value1 = getValue(for: stackPointer + 1, instruction: operationPointer, in: opcodes)
                operationPointer += 1
                let value2 = getValue(for: stackPointer + 2, instruction: operationPointer, in: opcodes)
                data[data[stackPointer + 3]] = value1 < value2 ? 1 : 0
                operationPointer = 2
                stackPointer += 4
            case .equals:
                let value1 = getValue(for: stackPointer + 1, instruction: operationPointer, in: opcodes)
                operationPointer += 1
                let value2 = getValue(for: stackPointer + 2, instruction: operationPointer, in: opcodes)
                data[data[stackPointer + 3]] = value1 == value2 ? 1 : 0
                operationPointer = 2
                stackPointer += 4
            case .finished:
                break
            default:
                fatalError()
                break
            }
        }
        print("Program ended")
    }
    
    var output:Int{
        return data[0]
    }
    
    func set(at position: Int, value:Int){
        data[position] = value
    }
}

extension IntCode{
    
    enum Instruction: Int{
        case add = 1
        case multiply = 2
        case finished = 99
        case input = 3
        case output = 4
        case jumpIfTrue = 5
        case jumpIfFalse = 6
        case lessThen = 7
        case equals = 8
        
    }
    enum Mode:Int{
        case position = 0
        case immediate = 1
    }
    
    func parseOpCode(_ code:Int) -> [Int] {
        var buffer = code
        var digits = [Int]()
        while buffer > 0 {
            digits.append(buffer % 10)
            buffer /= 10
        }
        return digits
    }
    
    func getValue(for stackPointer:Int,instruction:Int, in instructions:[Int]) -> Int{
        
        let mode:Mode
        if instruction >= instructions.count{
            mode = Mode.position
        } else {
            mode = Mode(rawValue: instructions[instruction]) ?? .position
        }
        
        switch mode {
        case .immediate:
            return data[stackPointer]
        case .position:
            return data[data[stackPointer]]
        default:
            fatalError()
        }
        
        return 0
    }
}
