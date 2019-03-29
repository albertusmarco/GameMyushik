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
    
    var playerScore:SKLabelNode!
    
    let answerBox = SKSpriteNode()
    let first = SKSpriteNode()
    let second = SKSpriteNode()
    let third = SKSpriteNode()
    
    var currentScore:Int = 0
    
    private var levelLabel : SKLabelNode?
    private var levelNumber : SKLabelNode?
    private var questionLabel : SKLabelNode?
    private var playAgainBtn : SKNode?
    private var notesLabel1 : SKLabelNode?
    private var notesLabel2 : SKLabelNode?
    private var notesLabel3 : SKLabelNode?
    private var notes : SKLabelNode?
    
    private var currentNode: SKNode?
    private var status: Bool?
    private var statusgame: Bool?
    let timer = CountdownLabel()
    
    //randomize notes
    var currentNote: Int = 0
    var otherNote1: Int = 0
    var otherNote2: Int = 0
    
    var urutan1: Int = 0
    var urutan2: Int = 0
    var urutan3: Int = 0
    
    //soal
    let noteList:[Int:String] = [
        0:"C3",
        1:"D3",
        2:"E3",
        3:"F3",
        4:"G3",
        5:"A3",
        6:"B3",
        7:"C4"
    ]
    
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
        
        playerScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        playerScore.zPosition = 1
        playerScore.position = CGPoint(x: 0, y: (frame.size.height / -2) + 50)
        playerScore.fontSize = 40
        playerScore.text = "Your Score: 0"
        playerScore.fontColor = SKColor.black
        self.addChild(playerScore)
        
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
        
        randomizeNotes()
        
        playSound(noteName: noteList[currentNote] ?? "C3")
    }
    
    func randomizeNotes() {
        currentNote = Int(arc4random_uniform(8))
        
        //generate notes
        repeat {
            otherNote1 = Int(arc4random_uniform(8))
        } while otherNote1 == currentNote
        
        repeat {
            otherNote2 = Int(arc4random_uniform(8))
        } while otherNote2 == currentNote || otherNote2 == otherNote1
        
        
        //generate urutan
        urutan1 = Int(arc4random_uniform(3))+1
        repeat {
            urutan2 = Int(arc4random_uniform(3))+1
        } while urutan2 == urutan1
        
        repeat {
            urutan3 = Int(arc4random_uniform(3))+1
        } while urutan3 == urutan1 || urutan3 == urutan2
        
        notesLabel1?.text = urutan1 == 1 ? noteList[currentNote] : urutan1 == 2 ? noteList[otherNote1] : noteList[otherNote2]
        notesLabel2?.text = urutan2 == 1 ? noteList[currentNote] : urutan2 == 2 ? noteList[otherNote1] : noteList[otherNote2]
        notesLabel3?.text = urutan3 == 1 ? noteList[currentNote] : urutan3 == 2 ? noteList[otherNote1] : noteList[otherNote2]
        
        print (urutan1 == 1 ? String(currentNote) : urutan1 == 2 ? String(otherNote1) : String(otherNote2))
        print (urutan2 == 1 ? String(currentNote) : urutan2 == 2 ? String(otherNote1) : String(otherNote2))
        print (urutan3 == 1 ? String(currentNote) : urutan3 == 2 ? String(otherNote1) : String(otherNote2))
        
//        print ("urutan1 " + String(urutan1))
//        print ("urutan2 " + String(urutan2))
//        print ("urutan3 " + String(urutan3))
        print ("yang benar " + String(currentNote))
        print("=========================")
        playSound(noteName: noteList[currentNote] ?? "C3")
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
                else if node.name == "btn_play_again" {
                    playSound(noteName: noteList[currentNote] ?? "C3")
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
            if urutan1 == 1 {
                rightAnswer()
                randomizeNotes()
            } else {
                wrongAnswer()
            }
        }
        else if answerBox.frame.contains(second.position) {
            if urutan2 == 1 {
                rightAnswer()
                randomizeNotes()
            } else {
                wrongAnswer()
            }
        }
        else if answerBox.frame.contains(third.position) {
            if urutan3 == 1 {
                rightAnswer()
                randomizeNotes()
            } else {
                wrongAnswer()
            }
        }
        self.currentNode = nil
        
        //Set Current Score to UserDefaults
        UserDefaults.standard.set(currentScore, forKey: "currentScore")
        
        //restart position
        first.position = CGPoint(x:-213,y:-198)
        second.position = CGPoint(x:-2,y:-198)
        third.position = CGPoint(x:213,y:-198)
    }
    
    func rightAnswer() {
        print("ANDA BENAR YEEAAH")
        //update score
        currentScore += 1
        playerScore.text = "Your Score: \(currentScore)"
        
        //up level
        var level = Int(levelNumber!.text!)
        level = level! + 1
        levelNumber?.text = String(level!)
        
        //restart timer
        timer.startWithDuration(duration: 10)
    }
    
    func wrongAnswer() {
        print("ANDA SALAH YEEAAH")
        //update score
        currentScore -= 1
        if currentScore < 0 {
            currentScore = 0
            playerScore.text = "Your Score: \(currentScore)"
        }
        else {
            playerScore.text = "Your Score: \(currentScore)"
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
                let resultScene = SKScene(fileNamed: "ResultScene")
                resultScene?.scaleMode = .aspectFill
                self.view?.presentScene(resultScene)
            }
        }
    }
    
    func playSound(noteName: String) {
        run(SKAction.playSoundFileNamed(noteName+".m4a", waitForCompletion: false))
    }
    
}
