//
//  FoodClass.swift
//  SimAnt
//
//  Created by Tom Shiflet on 2/16/18.
//  Copyright © 2018 Tom Shiflet. All rights reserved.
//

import Foundation
import SpriteKit

class FoodClass:EntityClass
{
    var sprite=SKSpriteNode()
    
    
    override init()
    {
        sprite=SKSpriteNode(imageNamed: "cookie")
        sprite.setScale(0.10)
    }
}
