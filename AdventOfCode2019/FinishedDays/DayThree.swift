//
//  DayThree.swift
//  AdventOfCode2019
//
//  Created by Stefan Haßferter on 13.12.19.
//  Copyright © 2019 Stefan Haßferter. All rights reserved.
//

func DayThree(){
    
    struct Point:Hashable {
        let x: Int
        let y: Int
    }
    
    func parseCable(data:[String], start:Point) -> [Point] {
        var points: [Point] = []
        var currentPoint = start
        
        data.forEach { instruction in
            switch instruction.prefix(1) {
            case "R":
                let count = Int(instruction.replacingOccurrences(of: "R", with: ""))!
                for _ in (1...count) {
                    let new = Point(x: currentPoint.x + 1, y: currentPoint.y)
                    points.append(new)
                    currentPoint = new
                }
            case "U":
                let count = Int(instruction.replacingOccurrences(of: "U", with: ""))!
                for _ in (1...count) {
                    let new = Point(x: currentPoint.x , y: currentPoint.y + 1)
                    points.append(new)
                    currentPoint = new
                }
            case "L":
                let count = Int(instruction.replacingOccurrences(of: "L", with: ""))!
                for _ in (1...count) {
                    let new = Point(x: currentPoint.x - 1, y: currentPoint.y)
                    points.append(new)
                    currentPoint = new
                }
            case "D":
                let count = Int(instruction.replacingOccurrences(of: "D", with: ""))!
                for _ in (1...count) {
                    let new = Point(x: currentPoint.x, y: currentPoint.y - 1)
                    points.append(new)
                    currentPoint = new
                }
            default:
                fatalError()
            }
        }
        return points
    }
    let startingPoint = Point(x: 0, y: 0)
    
//    let data1 = ["R8","U5","L5","D3"]
//    let data2 = ["U7","R6","D4","L4"]
    
    let data1 = ["U62","R66","U55","R34","D71","R55","D58","R83"]
    let data2 = ["R75","D30","R83","U83","L12","D49","R71","U7","L72"]
//    let data1 = ["R98","U47","R26","D63","R33","U87","L62","D20","R33","U53","R5"]
//    let data2 = ["U98","R91","D20","R16","D67","R40","U7","R15","U6","R7"]
    
    let cable1 = parseCable(data: DayThreeCable1, start: startingPoint)
    let cable2 = parseCable(data: DayThreeCable2, start: startingPoint)
    
    func searchForCuttingPoints(array1:[Point],array2:[Point]) -> [Point]{
        let set1 = Set(array1)
        let set2 = Set(array2)
        return Array(set1.intersection(set2))
    }
    
    func calcDistanceBetween(p1:Point, p2:Point) -> Int{
        return abs(p1.x - p2.x) + abs(p1.y - p2.y)
    }
    
    func searchSteps(form point:Point, in array:[Point]) -> Int {
        return array.firstIndex(of: point) ?? -1
    }
    
    let cuttingPoints = searchForCuttingPoints(array1: cable1, array2: cable2)
    
    
    let distances = cuttingPoints.map{calcDistanceBetween(p1: startingPoint, p2: $0)}
    
    var stepsCable1 = cuttingPoints.map{searchSteps(form: $0, in: cable1)}
    let stepsCable2 = cuttingPoints.map{searchSteps(form: $0, in: cable2)}
    
    for index in 0..<stepsCable1.count{
        stepsCable1[index] += stepsCable2[index]
    }
    
    //part1
    print(distances.min())
//  +2 cause of starting at 0 in array so +1 on each side
    print((stepsCable1.min() ?? 0) + 2)
}
