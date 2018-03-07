//
//  GameScene.swift
//  SimAnt
//
//  Created by Tom Shiflet on 1/29/18.
//  Copyright © 2018 Tom Shiflet. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    

    var myAnt=[AntClass]()
    var foodList=[FoodClass]()
    
    
    let maxAnts=250
    let circle=SKShapeNode(circleOfRadius: 20)
    let mound=MoundClass()
    
    
    
    override func didMove(to view: SKView) {
    
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        
        
        backgroundColor=NSColor.black
        
        // draw ant mound
        addChild(mound.sprite)
        
        
        
        circle.isHidden=true
        addChild(circle)
        
        
        for i in 0...maxAnts-1
        {
            let tempAnt=AntClass()
            tempAnt.speed=0.5
            myAnt.append(tempAnt)
            addChild(myAnt[i].sprite)
            myAnt[i].sprite.addChild(myAnt[i].boundary)
            myAnt[i].boundary.setScale(1/0.15)
            
        }
        
        
    } // func didMove
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else
        {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & physCat.Ant != 0) &&
            (secondBody.categoryBitMask & physCat.Food != 0))
        {
            if let tempAnt = firstBody.node as? SKShapeNode, let
                tempFood = secondBody.node as? SKShapeNode
            {
            
                // find the matching ant
                var thisAnt:Int = -1
                
                for i in 0...myAnt.count-1
                {
                    if myAnt[i].name == tempAnt.name
                    {
                        thisAnt=i
                        break
                        
                    } // if the things match
                } // for each ant
                
                var thisFood:Int = -1
                for i in 0...foodList.count-1
                {
                    if foodList[i].name == tempFood.name
                    {
                        thisFood=i
                    } // if matches
                } // for each food
                
                
                if thisAnt > -1 && myAnt[thisAnt].currentState == AntClass.AIStates.Wander
                {
                    print("Ant \(thisAnt) found food \(thisFood).")
                    myAnt[thisAnt].interceptTarget=foodList[thisFood]
                    myAnt[thisAnt].currentState=AntClass.AIStates.Intercept
                }
                
                
                
            } // if let
            
            
        } // if ((firstBody...)
        
    } // func didBegin()
    
    func touchDown(atPoint pos : CGPoint) {

        let food=FoodClass()
        food.position=pos
        food.sprite.position=pos
        foodList.append(food)
        
        let last=foodList.count-1
        
        
        addChild(foodList[last].sprite)
        foodList[last].sprite.addChild(foodList[last].boundary)
        foodList[last].boundary.setScale(1/0.1)
        
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {

        case 49:
            myAnt[0].currentState=AntClass.AIStates.Intercept
            myAnt[0].interceptTarget=myAnt[1]
            
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        } // switch key
    } // func keyDown
    
    
    func checkAntBoundaries()
    {
        
        for i in 0...myAnt.count-1
        {
            if !intersects(myAnt[i].sprite)
            {
                myAnt[i].sprite.removeFromParent()
                myAnt.remove(at: i)
                break
                
            } // if it's not on the screen
        } // for each ant
    } // func checkAntBoundaries
    

    
    func checkAddAnt()
    {
        if myAnt.count < maxAnts
        {
            let chance = random(min: 1, max: 100)
            if chance > 98.5
            {
                let tempAnt=AntClass()
                tempAnt.speed=0.5
                myAnt.append(tempAnt)
                addChild((myAnt.last?.sprite)!)
                myAnt[myAnt.count-1].sprite.addChild(myAnt[myAnt.count-1].boundary)
                myAnt[myAnt.count-1].boundary.setScale(1/0.15)
                
            }
            
        } // if we have less than the max # of ants
    } // checkAddAnt
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        checkAntBoundaries()
        checkAddAnt()
        
        if foodList.count > 0
        {
            for i in 0...foodList.count-1
            {
                if foodList[i].health < 0
                {
                    foodList[i].boundary.removeFromParent()
                    foodList[i].sprite.removeFromParent()
                    foodList.remove(at: i)
                    break
                }
            
            } // for each food
        } // if we have food
        
        for i in 0...myAnt.count-1
        {
            myAnt[i].update()
            if myAnt[i].currentState==AntClass.AIStates.GoToMound
            {
                myAnt[i].interceptTarget=mound
            }
            
            

        }
    } // func update
}
