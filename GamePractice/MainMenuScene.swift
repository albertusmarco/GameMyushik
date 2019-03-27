//
//  MainMenu.swift
//  GamePractice
//
//  Created by Hans Christian Yulianto on 27/03/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    private var startBtn: SKSpriteNode?
    private var tuneYourLabel : SKLabelNode?
    private var titleLabel : SKLabelNode?
    private var bestScoreLabel : SKLabelNode?
    private var scoreLabel : SKLabelNode?
    
    override func didMove(to view: SKView) {
        tuneYourLabel = self.childNode(withName: "label_tune_your") as? SKLabelNode
        titleLabel = self.childNode(withName: "label_pitch") as? SKLabelNode
        bestScoreLabel = self.childNode(withName: "label_best_score") as? SKLabelNode
        scoreLabel = self.childNode(withName: "value_score") as? SKLabelNode
        startBtn = self.childNode(withName: "btn_play") as? SKSpriteNode
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
                let gameScene = SKScene(fileNamed: "GameScene")
                self.view?.presentScene(gameScene)
            }
        }
    }
    
}
