//
//  DaySeven.swift
//  AdventOfCode2019
//
//  Created by Stefan Haßferter on 16.12.19.
//  Copyright © 2019 Stefan Haßferter. All rights reserved.
//

import Foundation
func DaySeven(){
    let computer = IntCode(data: [3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0])
    computer.run()
}
