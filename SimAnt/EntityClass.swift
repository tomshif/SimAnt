//
//  EntityClass.swift
//  SimAnt
//
//  Created by Tom Shiflet on 1/29/18.
//  Copyright © 2018 Tom Shiflet. All rights reserved.
//

import Foundation
import SpriteKit

struct physCat {
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max
    
    static let Ant          : UInt32 = 0b0010
    static let Food         : UInt32 = 0b0100
    static let Mound        : UInt32 = 0b1000
    
    
} // struct physCat



class EntityClass
{
    var position=CGPoint()
    var heading:CGFloat=0
    var speed:CGFloat=0
    var health:CGFloat=0
    
    var name:String=""
    var boundary=SKShapeNode()
    
    
    
    
    init()
    {
        position=CGPoint(x: 0, y: 0)
        name=UUID().uuidString
        
        
    }
    
} // class EntityClass
