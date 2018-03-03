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
        super.init()
        health=100
        boundary=SKShapeNode(circleOfRadius: health)
        boundary.zPosition=0
        boundary.fillColor=NSColor.clear
        sprite=SKSpriteNode(imageNamed: "cookie")
        sprite.setScale(0.10)
    }
}









