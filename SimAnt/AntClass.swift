//
//  AntClass.swift
//  SimAnt
//
//  Created by Tom Shiflet on 1/29/18.
//  Copyright © 2018 Tom Shiflet. All rights reserved.
//

import Foundation
import SpriteKit

class AntClass:EntityClass
{
    // Properties
    var currentState:UInt32=AIStates.Wander
    var lastUpdate=NSDate()
    var isTurning:Bool=false
    var turnTo:CGFloat=0
    var ID:String=""
    var lastWanderTurn=NSDate()
    var sprite=SKSpriteNode()
    var born=NSDate()
    
    // Constants
    let maxSpeed:CGFloat=1.0
    let maxTurn:CGFloat=0.1
    
    
    // Structures
    struct AIStates {
        static let None         : UInt32 = 0
        static let Wander       : UInt32 = 0b0001
    } // struct AIStates
    
    func update()
    {

        switch currentState
        {
        case AIStates.Wander:
            wander()
            
        default:
            print("Error -- Unknown State")
            
        } // switch current state
        
        
        
        
        // if we're turning, update rotation
        if isTurning
        {
            turning()
        } // if the ant is currently turning
        
        // update movement based on heading and speed
        
        heading=sprite.zRotation
        let dx=cos(heading)*speed
        let dy=sin(heading)*speed
        position.x+=dx
        position.y+=dy
        
        sprite.position=position
        
        
        // set last update time
        lastUpdate=NSDate()
        
    } // func update
    
    func wander()
    {
        let now=NSDate()
        // check to see if we need to turn
        if now.timeIntervalSince(lastWanderTurn as Date) > 0.35
        {
            var da:CGFloat=0
            da=random(min: -1, max: 1)
            
            da=heading+da

            turnTo(angle:da)
            
            lastWanderTurn=now
            print("Heading \(heading)")
        }
        
        // check to see if we need to speed up or slow down
        let speedChance=random(min: 0, max: 1.0)
        if speedChance > 0.85
        {
            let speedDelta = random(min: -0.3, max: 0.3)
            speed += speedDelta
            if speed < 0
            {
                speed = 0
            }
            if speed > maxSpeed
            {
                speed = maxSpeed
            }
        } // if we're going to change speed

        
        
    } // func wander
    
    func turnTo(angle: CGFloat)
    {
        let da=Double(heading-angle)

        sprite.run(SKAction.rotate(toAngle: angle, duration: 0.3))
    } // func turnTo
    
    func turning()
    {
  
        
        
    } // func turning
    
    
    
    override init()
    {
        super.init()
        heading=random(min: 0, max: CGFloat.pi*2)
        sprite=SKSpriteNode(imageNamed: "ant")
        sprite.position=position
        sprite.zRotation=heading
        sprite.setScale(0.15)
        currentState=AIStates.Wander
        
    } //
    
} // class AntClass
