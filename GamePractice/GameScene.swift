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
    
    var gameLogo1:SKLabelNode!
    var gameLogo2:SKLabelNode!
    var bestScore:SKLabelNode!
    var playButton: SKShapeNode!
    
    let answerBox = SKSpriteNode()
    let first = SKSpriteNode()
    let second = SKSpriteNode()
    let third = SKSpriteNode()
//    var game: GameManager!
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .white
        initMenu()
//        game = GameManager()
    }
    
    private func startGame() {
        print("start game")
        
        gameLogo1.run(SKAction.move(by: CGVector(dx: 0, dy: 600), duration: 0.5)) {
            self.gameLogo1.isHidden = true
        }
        
        gameLogo2.run(SKAction.move(by: CGVector(dx: 0, dy: 300), duration: 0.6))
        
        playButton.run(SKAction.scale(to: 0, duration: 0.3)) {
            self.playButton.isHidden = true
        }
        
        let bottomCorner = CGPoint(x: 0, y: (frame.size.height / -2) + 30)
        bestScore.run(SKAction.move(to: bottomCorner, duration: 0.4))
        
        initGameView()
    }
    
    private func initMenu(){
        gameLogo1 = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        gameLogo1.zPosition = 1
        gameLogo1.position = CGPoint(x: 0, y: (frame.size.height / 2) - 400)
        gameLogo1.fontSize = 80
        gameLogo1.text = "Tune Your"
        gameLogo1.fontColor = SKColor.red
        self.addChild(gameLogo1)
        
        gameLogo2 = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        gameLogo2.zPosition = 1
        gameLogo2.position = CGPoint(x: 0, y: gameLogo1.position.y - 150)
        gameLogo2.fontSize = 120
        gameLogo2.text = "Pitch"
        gameLogo2.fontColor = SKColor.black
        self.addChild(gameLogo2)
        
        
        bestScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        bestScore.zPosition = 1
        bestScore.position = CGPoint(x: 0, y: gameLogo2.position.y - 100)
        bestScore.fontSize = 40
        bestScore.text = "Best Score: 0"
        bestScore.fontColor = SKColor.black
        self.addChild(bestScore)
        
        print("masuk init game view")
        
        playButton = SKShapeNode()
        playButton.name = "play_button"
        playButton.zPosition = 1
        playButton.position = CGPoint(x: 0, y: (frame.size.height / -2) + 400)
        playButton.fillColor = SKColor.black
        
        let topCorner = CGPoint(x: -50, y: 50)
        let bottomCorner = CGPoint(x: -50, y: -50)
        let middle = CGPoint(x: 50, y: 0)
        let path = CGMutablePath()
        path.addLine(to: topCorner)
        path.addLines(between: [topCorner, bottomCorner, middle])
        
        playButton.path = path
        self.addChild(playButton)
    }
    
    
    
    private var currentNode: SKNode?
    private var status: Bool?
    private var statusgame: Bool?
    let timer = CountdownLabel()
    
    private func initGameView(){
        statusgame = true
        
        timer.position = CGPoint(x:5,y:274)
        timer.fontSize = 65
        addChild(timer)
        timer.startWithDuration(duration: 10)
        
        first.color = .red
        first.size = CGSize(width: 100, height: 100)
        first.name = "firstAnswer"
        first.position = CGPoint(x:-213,y:-198)
        self.addChild(first)
        
        second.color = .blue
        second.size = CGSize(width: 100, height: 100)
        second.name = "secondAnswer"
        second.position = CGPoint(x:-2,y:-198)
        self.addChild(second)
        
        third.color = .green
        third.size = CGSize(width: 100, height: 100)
        third.name = "thirdAnswer"
        third.position = CGPoint(x:213,y:-198)
        self.addChild(third)
        
        answerBox.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        answerBox.size = CGSize(width: 100, height: 100)
        answerBox.position = CGPoint(x: -0.8, y: -480)
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
        //menu touch
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode {
                if node.name == "play_button" {
                    startGame()
                }
            }
        }
        
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
        
        //If touch the answer box, score up
        if answerBox.frame.contains(first.position) {
            print("ANDA BENAR YEEAAH")
            //TODO: Update score, go to next level
            
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
            }
        }
    }
}
