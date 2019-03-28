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
    var bestScore:SKLabelNode!
    var currentScore:Int = 0
    var startBtn: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        startBtn = self.childNode(withName: "btn_play") as? SKSpriteNode
        
        bestScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        bestScore.zPosition = 1
        bestScore.position = CGPoint(x: 0, y: (frame.size.height / -2) + 50)
        bestScore.fontSize = 40
        bestScore.text = "Best Score: 0"
        bestScore.fontColor = SKColor.black
        self.addChild(bestScore)
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
