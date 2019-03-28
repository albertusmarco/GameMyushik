//
//  ResultScene.swift
//  GamePractice
//
//  Created by Marco Jordiansyah on 28/03/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import SpriteKit
import GameplayKit

class ResultScene: SKScene{
    var bestScoreLabel:SKLabelNode!
    var currentScore:Int = 0
    var startBtn: SKSpriteNode?
    var currentScoreLabel: SKLabelNode?
    var bestScore: Int?
    
    override func didMove(to view: SKView) {
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        startBtn = self.childNode(withName: "btn_play") as? SKSpriteNode
        currentScoreLabel = self.childNode(withName: "scoreNumber") as? SKLabelNode
        
        
        currentScore = UserDefaults.standard.integer(forKey: "currentScore")
        
        currentScoreLabel?.text = String(currentScore)
        
        print("current score: \(currentScore)")
        bestScore = UserDefaults.standard.integer(forKey: "bestScore")
        
        //Tambah UserDefaults ke UserDefaults; key: bestScore
        if  currentScore > bestScore ?? 0{
                UserDefaults.standard.set(currentScore, forKey: "bestScore")
                bestScore = currentScore
            }
        
        print("best: \(bestScore!)")
        
        bestScoreLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        bestScoreLabel.zPosition = 1
        bestScoreLabel.position = CGPoint(x: 0, y: (frame.size.height / -2) + 50)
        bestScoreLabel.fontSize = 40
        bestScoreLabel.text = "Best Score: \(bestScore!)"
        bestScoreLabel.fontColor = SKColor.black
        self.addChild(bestScoreLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        let nodes = self.nodes(at: pos)
        
        if let button = startBtn {
            if nodes.contains(button) {
                let mainMenuScene = SKScene(fileNamed: "MainMenuScene")
                mainMenuScene?.scaleMode = .aspectFill
                self.view?.presentScene(mainMenuScene)
            }
        }
    }
}
