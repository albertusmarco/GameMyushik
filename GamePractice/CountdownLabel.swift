//
//  CountdownLabel.swift
//  GamePractice
//
//  Created by Marco Jordiansyah on 26/03/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import SpriteKit
class CountdownLabel: SKLabelNode {
    var endTime:Date!
    
    
    func update(){
        let timeLeftInteger = Int(timeLeft())
        text = String(timeLeftInteger)
    }
    
    func startWithDuration(duration: TimeInterval){
        let timeNow = Date()
        endTime = timeNow.addingTimeInterval(duration)
    }
    
    func hasFinished() -> Bool{
        return timeLeft() == 0
    }
    
    private func timeLeft() -> TimeInterval{
        let now = Date();
        let remainingSeconds = endTime.timeIntervalSince(now)
        return max(remainingSeconds, 0)
    }
}
