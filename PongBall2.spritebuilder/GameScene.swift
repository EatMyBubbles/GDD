//
//  GameScene.swift
//  PongBall2
//
//  Created by Christopher Zhao on 7/23/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class GameScene: CCNode, CCPhysicsCollisionDelegate {
    
    weak var ball: CCSprite!
    weak var rightPaddle: Paddle!
    weak var leftPaddle: Paddle!
    weak var gamePhysicsNode: CCPhysicsNode!
    weak var restartButton: CCButton!
    weak var scoreLabel: CCLabelTTF!
    weak var scoreLabel2: CCLabelTTF!
    weak var coinLabel: CCLabelTTF!
    weak var coinLabel2: CCLabelTTF!
    weak var bestLabel: CCLabelTTF!
    
    var width = CCDirector.sharedDirector().viewSize().width
    var gameOver: Bool = false
    var wantSpawn: Bool = true
    var score: Int = 0 {
        didSet {
            scoreLabel.string = "\(score)"
            scoreLabel2.string = "\(score)"
        }
    }
    var money: Int = 0 {
        didSet {
            coinLabel.string = "\(money)"
            coinLabel2.string = "\(money)"
        }
    }
    
    
    func didLoadFromCCB() {
        multipleTouchEnabled = true
        userInteractionEnabled = true
        gamePhysicsNode.collisionDelegate = self
        
        self.animationManager.runAnimationsForSequenceNamed("Countdown")
        
//        delay(3) { // always use "self." when using delay
//            self.schedule("spawnCoin", interval: 2.5)
//        }
        
    }
    
//    func delay(delay:Double, closure:() ->()) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
//    }
    
    func ballPush() {                                                   //give ball initial velocity
        var ballX = CGFloat(arc4random() % 2)
        var ballY = CGFloat(arc4random() % 2)
        
        if ballX == 0 {
            ball.physicsBody.velocity.x = 150
        } else {
            ball.physicsBody.velocity.x = -150
        }
        
        if ballY == 0 {
            ball.physicsBody.velocity.y = 75
        } else {
            ball.physicsBody.velocity.y = -75
        }
        
        
    }
    
    func spawnCoin() {                                                  //spawnCoin method
        if wantSpawn == true {
            var spawnX = ((((arc4random() % 17) + 1) * 20) + 104)
            var spawnY = ((((arc4random() % 10) + 1) * 25) + 25)
            var coin = CCBReader.load("Coin") as! Coin
            coin.position = ccp(CGFloat(spawnX), CGFloat(spawnY))
            coin.scale = Float(0.2)
            gamePhysicsNode.addChild(coin)
            //        println(coin.position)

        }
    }
    
    func spawnCoinInterval() {
        schedule("spawnCoin", interval: 2.5)
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, ball nodeA: CCNode!, paddle nodeB: CCNode!) -> ObjCBool {
        
        if ball.physicsBody.elasticity < 1.1 && ball.physicsBody.velocity.x < 950 && ball.physicsBody.velocity.x > -950 {
            ball.physicsBody.elasticity += 0.1
        } else if ball.physicsBody.elasticity == 1.1 {
            ball.physicsBody.elasticity -= 0.1
        }
        
        score++
        
//        println(ball.physicsBody.velocity)
        
        return true
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, coin: CCNode!, ball: CCNode!) -> ObjCBool {
        
        coin.removeFromParent()
        money++
        
        return false
    }
    
    func GameOver() {
        println("GameOver")
        gameOver = true
        
        self.animationManager.runAnimationsForSequenceNamed("GameOver")
        
        //highscore code
        let defaults = NSUserDefaults.standardUserDefaults()
        var highscore = defaults.integerForKey("highscore")
        if score > highscore {
            defaults.setInteger(score, forKey: "highscore")
        }
        
        //set highscore
        var newHighscore = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
        bestLabel.string = "\(newHighscore)"
        
//        var gameOverScene = CCBReader.loadAsScene("GameOver")
//        var transition = CCTransition(moveInWithDirection: .Down, duration: 0.5)
//        CCDirector.sharedDirector().presentScene(gameOverScene, withTransition: transition)
    }
    
    func restart() {
        let gameplayScene = CCBReader.loadAsScene("Gameplay")
        CCDirector.sharedDirector().presentScene(gameplayScene)
    }
    
    override func update(delta: CCTime) {
        
        if ball.position.x > 1 && gameOver == false {
            GameOver()
        }
        else if ball.position.x < 0 && gameOver == false {
            GameOver()
        }
        
        let velocityX = clampf(Float(ball.physicsBody.velocity.x), -Float(CGFloat.max),950)
        ball.physicsBody.velocity = ccp(CGFloat(velocityX), CGFloat(ball.physicsBody.velocity.y))
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        
        var touchY = touch.locationInNode(CCPhysicsNode()!).y
        var touchX = touch.locationInNode(CCPhysicsNode()!).x
        
        if touchX > width/2 {
            rightPaddle.positionInPoints.y = touchY
        }
        else {
            leftPaddle.positionInPoints.y = touchY
        }
        
    }
    
    override func touchMoved(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        var touchY = touch.locationInNode(CCPhysicsNode()!).y
        var touchX = touch.locationInNode(CCPhysicsNode()!).x
        
        if touchX > width/2 {
            rightPaddle.positionInPoints.y = touchY
        }
        else {
            leftPaddle.positionInPoints.y = touchY
        }
        
    }
}