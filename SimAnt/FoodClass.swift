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
        
        boundary.fillColor=NSColor.clear
        boundary.isHidden=true
        boundary.physicsBody = SKPhysicsBody(circleOfRadius: health)
        boundary.physicsBody?.isDynamic = true
        boundary.physicsBody?.categoryBitMask = physCat.Food
        boundary.physicsBody?.contactTestBitMask = physCat.Ant
        boundary.physicsBody?.collisionBitMask = physCat.None
        boundary.physicsBody?.usesPreciseCollisionDetection = true
        boundary.name=name
        
        sprite=SKSpriteNode(imageNamed: "cookie")
        sprite.setScale(0.10)
        sprite.zPosition=2
    }
}









