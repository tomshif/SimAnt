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
    let maxAnts=30
    let circle=SKShapeNode(circleOfRadius: 20)
    let mound=MoundClass()
    
    
    
    override func didMove(to view: SKView) {
    
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        
        
        backgroundColor=NSColor.brown
        
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
    
    
    func touchDown(atPoint pos : CGPoint) {

        let food=FoodClass()
        food.position=pos
        food.sprite.position=pos
        addChild(food.sprite)
        food.sprite.addChild(food.boundary)
        food.boundary.setScale(1/0.1)
        
        for i in 0...myAnt.count-1
        {
            myAnt[i].currentState = AntClass.AIStates.Intercept
            myAnt[i].interceptTarget=food
        }
        
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
