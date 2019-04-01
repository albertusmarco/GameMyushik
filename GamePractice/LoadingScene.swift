////
//  OnboardScene.swift
//  GamePractice
//
//  Created by Marco Jordiansyah on 01/04/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import SpriteKit
import GameplayKit

class LoadingScene: SKScene {
    let timer = CountdownLabel()
    var statusgame: Bool?
    var mainGuy = SKSpriteNode()
    var TextureAtlas = SKTextureAtlas()
    var TextureArray = [SKTexture]()
    
    override func didMove(to view: SKView) {
        TextureAtlas = SKTextureAtlas(named: "loading")
        
        for i in 1...TextureAtlas.textureNames.count {
            let name = "\(i).png"
            TextureArray.append(TextureAtlas.textureNamed(name))
            print(name)
        }
        
        mainGuy = SKSpriteNode(texture: TextureArray[0])
        mainGuy.size = CGSize(width: 750, height: 1334)
        mainGuy.position = CGPoint(x: 0, y: 0)
        self.addChild(mainGuy)
        mainGuy.run(SKAction.repeatForever(SKAction.animate(with: TextureArray, timePerFrame: 0.1)))
        
        statusgame = true
        addChild(timer)
        timer.startWithDuration(duration: 3)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if (statusgame == true) {
            if (timer.update()) {
                print("game end")
                statusgame = false
                let gameScene = SKScene(fileNamed: "GameScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene)
            }
        }
    }
}
