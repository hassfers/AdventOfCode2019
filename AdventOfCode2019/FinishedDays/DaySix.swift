//
//  DaySix.swift
//  AdventOfCode2019
//
//  Created by Stefan Haßferter on 16.12.19.
//  Copyright © 2019 Stefan Haßferter. All rights reserved.
//

func DaySix() {
    
    var centers:[String] = []
    var orbits:[String] = []
    
//        let input = ["COM)B","B)C","C)D","D)E","E)F","B)G","G)H","D)I","E)J","J)K","K)L","K)YOU","I)SAN"]
    
    let input = DaySixData
    input.map{
        orbits.append(String($0.split(separator: ")")[1]))
        centers.append(String($0.split(separator: ")").first!))
    }
    
    func searchCenter(for planet:String) -> Int? {
        return orbits.firstIndex(of: planet)
    }
    
    func disctanceToCenter(for planet:String, start:Int) -> Int{
        guard let distance = searchCenter(for: planet) else { return 0}
        return start + disctanceToCenter(for: centers[distance], start: start)
    }
    
    func wayBackToCOM(from planet:String) -> [String]{
        var planets:[String] = []
        var buffer = planet
        while buffer != "COM"{
            if let index = searchCenter(for: buffer){
                planets.append(buffer)
                buffer = centers[index]
            }
        }
        return planets
    }
    
    var orbitsCount = 1
    var running = 1
    
//    for n in 0 ..< centers.count {
//        var center = centers[n]
//        orbitsCount += 1
//        orbitsCount += disctanceToCenter(for: center,start: 1)
//    }
    
        for n in 0 ..< centers.count {
            orbitsCount += wayBackToCOM(from: centers[n]).count
        }
    
    print("part 1")
    print(orbitsCount)

    var wayBackYOU = wayBackToCOM(from: "YOU").reverse()
    var wayBackSAN = wayBackToCOM(from: "SAN").reverse()

    wayBackYOU.removeLast()
    wayBackSAN.removeLast()
    
    var cutting:String = ""
    
    for i in 0 ..< wayBackYOU.count{
        if wayBackYOU[i] != wayBackSAN[i]{
            cutting = wayBackSAN[i-1]
            break
        }
    }
    print("cutting: \(cutting)")
    
    let cuttingDistanceYou = wayBackYOU.reverse().firstIndex(of: cutting)!
    let cuttingDistanceSan = wayBackSAN.reverse().firstIndex(of: cutting)!
    
    let distance = cuttingDistanceYou + cuttingDistanceSan
    print("part2")
    
    print(distance)
}

extension Array {
    func reverse() -> [Element] {
        var buffer:[Element] = []
        let max = self.count - 1
        for i in (0 ... max).reversed(){
            buffer.append(self[i])
        }
        return buffer
    }
}

