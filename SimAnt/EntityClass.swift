//
//  EntityClass.swift
//  SimAnt
//
//  Created by Tom Shiflet on 1/29/18.
//  Copyright © 2018 Tom Shiflet. All rights reserved.
//

import Foundation
import SpriteKit

class EntityClass
{
    var position=CGPoint()
    var heading:CGFloat=0
    var speed:CGFloat=0
    var name:String=""
    
    
    
    
    init()
    {
        position=CGPoint(x: 0, y: 0)
        name=UUID().uuidString
        
    }
    
} // class EntityClass
