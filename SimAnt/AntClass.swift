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
    var goToPoint=CGPoint(x: 0, y: 0)
    var interceptTarget:EntityClass?
    
    
    // Constants
    let maxSpeed:CGFloat=1.0
    let maxTurn:CGFloat=0.1
    
    
    // Structures
    struct AIStates {
        static let None         : UInt32 = 0
        static let Wander       : UInt32 = 0b0001
        static let GoTo         : UInt32 = 0b0010
        static let Intercept    : UInt32 = 0b0100
        static let GoToMound    : UInt32 = 0b1000
        
        
    } // struct AIStates
    
    func update()
    {
        if sprite.zRotation > CGFloat.pi*2
        {
            sprite.zRotation = sprite.zRotation.remainder(dividingBy: CGFloat.pi*2)
        }
        if sprite.zRotation < -CGFloat.pi*2
        {
            sprite.zRotation = -sprite.zRotation.remainder(dividingBy: CGFloat.pi*2)
        }

        switch currentState
        {
        case AIStates.Wander:
            wander()
            
        case AIStates.GoTo:
            goTo(pos: goToPoint)
            
        case AIStates.Intercept:
            if interceptTarget != nil
            {
                intercept()
            }
            else
            {
                currentState=AIStates.Wander
            }
            
        case AIStates.GoToMound:
            if interceptTarget != nil
            {
                intercept()
            }
            else
            {
                currentState=AIStates.Wander
            }
        default:
            print("Error -- Unknown State")
            
        } // switch current state
        
        
        
    
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
    
    func intercept()
    {
        let dx=interceptTarget!.position.x-position.x
        let dy=interceptTarget!.position.y-position.y
        var angle=atan2(dy, dx)

        
        sprite.run(SKAction.rotate(toAngle: angle, duration: 0.3, shortestUnitArc: true))

        print("Turn To Angle: \(angle)")
        
        let dist=sqrt((dy*dy)+(dx*dx))
        
        if dist < 20 && currentState==AIStates.GoToMound
        {
            currentState=AIStates.Wander
        }
        
        
        if currentState==AIStates.Intercept && dist < 20
        {
            if let foodTest = interceptTarget as? FoodClass
            {
                currentState=AIStates.GoToMound
                
            }
            
        }
        
        

        
        speed=maxSpeed
        
        
        
    } // func intercept
    
    
    func goTo(pos: CGPoint)
    {
        let dx=pos.x-position.x
        let dy=pos.y-position.y
        var angle=atan2(dy, dx)
        /*
        if angle < 0
        {
            angle = angle + (CGFloat.pi*2)
        }
        */
        
        sprite.run(SKAction.rotate(toAngle: angle, duration: 0.3, shortestUnitArc: true))
        //sprite.run(SKAction.rotate(toAngle: angle, duration: 0.3))
        
        print("Turn To Angle: \(angle)")
        
        let dist=sqrt((dy*dy)+(dx*dx))
        if dist < 20
        {
            currentState=AIStates.Wander
        }
        
        speed=maxSpeed
        
        
    } // func goTo
    
    
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
            //print("Heading \(heading)")
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
    

    
    
    
    override init()
    {
        super.init()
        
        health=10
        
        
        
        boundary=SKShapeNode(circleOfRadius: health)
        
        boundary.zPosition=0
        boundary.fillColor=NSColor.clear
        boundary.physicsBody = SKPhysicsBody(circleOfRadius: health)
        boundary.physicsBody?.isDynamic = true
        boundary.physicsBody?.categoryBitMask = physCat.Ant
        boundary.physicsBody?.contactTestBitMask = physCat.Food
        boundary.physicsBody?.collisionBitMask = physCat.None
        boundary.physicsBody?.usesPreciseCollisionDetection = true
        
        
        
        heading=random(min: 0, max: CGFloat.pi*2)
        sprite=SKSpriteNode(imageNamed: "ant")
        sprite.position=position
        sprite.zRotation=heading
        sprite.setScale(0.15)
        currentState=AIStates.Wander
        
    } //
    
} // class AntClass
