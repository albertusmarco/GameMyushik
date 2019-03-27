//
//  GameScene.swift
//  GamePractice
//
//  Created by Marco Jordiansyah on 26/03/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var currentNode: SKNode?
    private var status: Bool?
    private var statusgame: Bool?
    let timer = CountdownLabel()
    
    override func didMove(to view: SKView) {
        statusgame = true
        
        timer.position = CGPoint(x:5,y:274)
        timer.fontSize = 65
        addChild(timer)
        timer.startWithDuration(duration: 10)
        
        let first = SKSpriteNode(
            color: .red,
            size: CGSize(width: 100, height: 100)
        )
        first.name = "firstAnswer"
        first.position = CGPoint(x:-213,y:-198)
        self.addChild(first)
        
        let second = SKSpriteNode(
            color: .blue,
            size: CGSize(width: 100, height: 100)
        )
        second.name = "secondAnswer"
        second.position = CGPoint(x:-2,y:-198)
        self.addChild(second)

        let third = SKSpriteNode(
            color: .green,
            size: CGSize(width: 100, height: 100)
        )
        third.name = "thirdAnswer"
        third.position = CGPoint(x:213,y:-198)
        self.addChild(third)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes.reversed() {
                if node.name == "firstAnswer" {
                    self.currentNode = node
                }
                else if node.name == "secondAnswer" {
                    self.currentNode = node
                }
                else if node.name == "thirdAnswer" {
                    self.currentNode = node
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)
            node.position = touchLocation
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if (statusgame == true) {
            if (timer.update()) {
                print("game end")
                statusgame = false
            }
        }
    }
}
