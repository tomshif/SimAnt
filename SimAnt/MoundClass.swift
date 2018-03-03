//
//  MoundClass.swift
//  SimAnt
//
//  Created by Tom Shiflet on 2/20/18.
//  Copyright © 2018 Tom Shiflet. All rights reserved.
//

import Foundation
import SpriteKit

class MoundClass:EntityClass
{
    var sprite=SKSpriteNode()
    
    override init()
    {
        super.init()
        sprite=SKSpriteNode(imageNamed: "antMound")
        sprite.setScale(0.03)
        
    }
    
} // class MoundClass
