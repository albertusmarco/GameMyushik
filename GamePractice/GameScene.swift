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

    var bestScore:SKLabelNode!
    
    let answerBox = SKSpriteNode()
    let first = SKSpriteNode()
    let second = SKSpriteNode()
    let third = SKSpriteNode()
    
    var currentScore:Int = 0
    
    private var levelLabel : SKLabelNode?
    private var levelNumber : SKLabelNode?
    private var questionLabel : SKLabelNode?
    private var notesLabel1 : SKLabelNode?
    private var notesLabel2 : SKLabelNode?
    private var notesLabel3 : SKLabelNode?
    private var notes : SKLabelNode?
    
    private var currentNode: SKNode?
    private var status: Bool?
    private var statusgame: Bool?
    let timer = CountdownLabel()
    
    override func didMove(to view: SKView) {
//        self.backgroundColor = .white
        levelLabel = self.childNode(withName: "levelLabel") as? SKLabelNode
        levelNumber = self.childNode(withName: "levelNumber") as? SKLabelNode
        questionLabel = self.childNode(withName: "questionLabel") as? SKLabelNode
        notesLabel1 = self.childNode(withName: "notesLabel1") as? SKLabelNode
        notesLabel2 = self.childNode(withName: "notesLabel2") as? SKLabelNode
        notesLabel3 = self.childNode(withName: "notesLabel3") as? SKLabelNode
        notes = self.childNode(withName: "notes") as? SKLabelNode
        
        initGameView()
    }
    
    
    private func initGameView(){
        self.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1)
        statusgame = true
        
        bestScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        bestScore.zPosition = 1
        bestScore.position = CGPoint(x: 0, y: (frame.size.height / -2) + 50)
        bestScore.fontSize = 40
        bestScore.text = "Best Score: 0"
        bestScore.fontColor = SKColor.black
        self.addChild(bestScore)
        
        timer.position = CGPoint(x:5,y:274)
        timer.fontSize = 65
        addChild(timer)
        timer.startWithDuration(duration: 10)
        
        first.color = .red
        first.size = CGSize(width: 100, height: 100)
        first.name = "firstAnswer"
        first.position = CGPoint(x:-213,y:-198)
        answerBox.zPosition = 0
        self.addChild(first)
        
        second.color = .blue
        second.size = CGSize(width: 100, height: 100)
        second.name = "secondAnswer"
        second.position = CGPoint(x:-2,y:-198)
        answerBox.zPosition = 0
        self.addChild(second)
        
        third.color = .green
        third.size = CGSize(width: 100, height: 100)
        third.name = "thirdAnswer"
        third.position = CGPoint(x:213,y:-198)
        answerBox.zPosition = 0
        self.addChild(third)
        
        answerBox.color =  .white
        answerBox.size = CGSize(width: 100, height: 100)
        answerBox.position = CGPoint(x: -0.8, y: -480)
        answerBox.zPosition = -1
        addChild(answerBox)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Get a Touch
        let touch = touches.first!
        
        //If It started in the label, move to the new location
        if first.frame.contains(touch.previousLocation(in: self)){
            first.position = touch.location(in: self)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //game touch
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
        //If touch the answer box
        if answerBox.frame.contains(first.position) {
            print("ANDA BENAR YEEAAH")
            //update score
            currentScore += 1
            bestScore.text = "Best Score: \(currentScore)"
            
            //restart position
            first.position = CGPoint(x:-213,y:-198)
            second.position = CGPoint(x:-2,y:-198)
            third.position = CGPoint(x:213,y:-198)
            
            //up level
            var level = Int(levelNumber!.text!)
            level = level! + 1
            levelNumber?.text = String(level!)
            
            //restart timer
            timer.startWithDuration(duration: 10)
        }
        else if answerBox.frame.contains(second.position) {
            print("ANDA SALAH YEEAAH")
            //update score
            currentScore -= 1
            bestScore.text = "Best Score: \(currentScore)"
            
            //restart position
            first.position = CGPoint(x:-213,y:-198)
            second.position = CGPoint(x:-2,y:-198)
            third.position = CGPoint(x:213,y:-198)
        }
        else if answerBox.frame.contains(third.position) {
            print("ANDA SALAH YEEAAH")
            //update score
            currentScore -= 1
            bestScore.text = "Best Score: \(currentScore)"
            
            //restart position
            first.position = CGPoint(x:-213,y:-198)
            second.position = CGPoint(x:-2,y:-198)
            third.position = CGPoint(x:213,y:-198)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if (statusgame == true) {
            if (timer.update()) {
                print("game end")
                statusgame = false
                let mainMenuScene = SKScene(fileNamed: "MainMenuScene")
                mainMenuScene?.scaleMode = .aspectFill
                self.view?.presentScene(mainMenuScene)
            }
        }
    }
}
