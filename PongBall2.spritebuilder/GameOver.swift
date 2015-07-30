//
//  GameOver.swift
//  PongBall2
//
//  Created by Christopher Zhao on 7/30/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class GameOver: CCNode {
    
    var scoreLabel: CCLabelTTF!
    var score: Int = 0 {
        didSet {
            scoreLabel.string = "\(score)"
        }
    }
    
    func restart() {
        let gameplayScene = CCBReader.loadAsScene("Gameplay")
        CCDirector.sharedDirector().presentScene(gameplayScene)
    }
}