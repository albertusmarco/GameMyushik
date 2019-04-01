//
//  MainMenu.swift
//  GamePractice
//
//  Created by Hans Christian Yulianto on 27/03/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import SpriteKit
import SceneKit
import AVKit
import ARKit

class MainMenuScene: SKScene {
    
    private var startBtn: SKSpriteNode?
    private var tuneYourLabel : SKLabelNode?
    private var titleLabel : SKLabelNode?
    private var bestScoreLabel:SKLabelNode!
    private var scoreLabel : SKLabelNode?
    private var bestScore:Int = 0
    private var background: SKSpriteNode?
    
    var mainGuy = SKSpriteNode()
    var TextureAtlas = SKTextureAtlas()
    var TextureArray = [SKTexture]()
    
    override func didMove(to view: SKView) {
        TextureAtlas = SKTextureAtlas(named: "seq")

        for i in 1...TextureAtlas.textureNames.count {
            let name = "\(i).png"
            TextureArray.append(SKTexture(imageNamed: name))
            print(name)
        }
        
        mainGuy = SKSpriteNode(imageNamed: TextureAtlas.textureNames[0])

        mainGuy.size = CGSize(width: 70, height: 140)
        mainGuy.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(mainGuy)
        
        background = self.childNode(withName: "background") as? SKSpriteNode
        background = SKSpriteNode(imageNamed: TextureAtlas.textureNames[0])
        background!.run(SKAction.repeatForever(SKAction.animate(with: TextureArray, timePerFrame: 0.1)))
        
        tuneYourLabel = self.childNode(withName: "label_tune_your") as? SKLabelNode
        titleLabel = self.childNode(withName: "label_pitch") as? SKLabelNode
        
        scoreLabel = self.childNode(withName: "value_score") as? SKLabelNode
        startBtn = self.childNode(withName: "btn_play") as? SKSpriteNode
        
        bestScore = UserDefaults.standard.integer(forKey: "bestScore")
        bestScoreLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        bestScoreLabel.zPosition = 1
        bestScoreLabel.position = CGPoint(x: 0, y: 20.505)
        bestScoreLabel.fontSize = 40
        bestScoreLabel.text = "Best Score: \(bestScore)"
        bestScoreLabel.fontColor = SKColor.black
        self.addChild(bestScoreLabel)
        
        //Delete Current Score from previous game
        UserDefaults.standard.removeObject(forKey: "currentScore")
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        background!.run(SKAction.repeatForever(SKAction.animate(with: TextureArray, timePerFrame: 0.1)))
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        let nodes = self.nodes(at: pos)
        
        if let button = startBtn {
            if nodes.contains(button) {
                let gameScene = SKScene(fileNamed: "GameScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene)
            }
        }
    }
    
}
