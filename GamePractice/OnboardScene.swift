////
//  OnboardScene.swift
//  GamePractice
//
//  Created by Marco Jordiansyah on 01/04/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import SpriteKit
import GameplayKit

class OnboardScene: SKScene {
    let timer = CountdownLabel()
    var statusgame: Bool?
    
    override func didMove(to view: SKView) {
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
                let mainMenuScene = SKScene(fileNamed: "MainMenuScene")
                mainMenuScene?.scaleMode = .aspectFill
                self.view?.presentScene(mainMenuScene)
            }
        }
    }
}
