//
//  GameScene.swift
//  SimAnt
//
//  Created by Tom Shiflet on 1/29/18.
//  Copyright © 2018 Tom Shiflet. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    

    var myAnt=[AntClass]()
    let mound=SKShapeNode(circleOfRadius: 12)
    let maxAnts=50
    
    override func didMove(to view: SKView) {
    
        // draw ant mound
        mound.fillColor=NSColor.brown
        mound.zPosition=0
        addChild(mound)
        
        
        
        for i in 1...maxAnts
        {
            var tempAnt=AntClass()
            tempAnt.speed=0.5
            myAnt.append(tempAnt)
            addChild(myAnt[i-1].sprite)
            
        }

    } // func didMove
    
    
    func touchDown(atPoint pos : CGPoint) {

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
    
    func checkAntAtMound()
    {
        let now=NSDate()
        
        for i in 0...myAnt.count-1
        {
            let timeDelta=now.timeIntervalSince(myAnt[i].born as Date)
            if timeDelta > 3.0 && mound.contains(myAnt[i].sprite.position)
            {
                myAnt[i].sprite.removeFromParent()
                myAnt.remove(at: i)
                break
                
            } // if the ant is at the mound
        } // for each ant
    } // func checkAntAtMound
    
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
            }
            
        } // if we have less than the max # of ants
    } // checkAddAnt
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        checkAntBoundaries()
        checkAntAtMound()
        checkAddAnt()
        
        for i in 0...myAnt.count-1
        {
            myAnt[i].update()
        }
    } // func update
}
