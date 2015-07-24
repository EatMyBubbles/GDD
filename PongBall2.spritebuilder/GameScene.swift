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
    
    var width = CCDirector.sharedDirector().viewSize().width
    var gameOver: Bool = false
    var ballSpeed = 1
    
    
    
    func didLoadFromCCB() {
        multipleTouchEnabled = true
        userInteractionEnabled = true
        gamePhysicsNode.collisionDelegate = self
        
        self.animationManager.runAnimationsForSequenceNamed("Countdown")
        
        delay(3) {
            self.ballPush()
        }
        
    }
    
    func delay(delay:Double, closure:() ->()) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
    }
    
    func ballPush() {
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
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, ball nodeA: CCNode!, paddle nodeB: CCNode!) -> ObjCBool {
        
        if ball.physicsBody.elasticity < 1.1 && ball.physicsBody.velocity.x < 950 && ball.physicsBody.velocity.x > -950 {
            ball.physicsBody.elasticity += 0.1
        } else if ball.physicsBody.elasticity == 1.1 {
            ball.physicsBody.elasticity -= 0.1
        }
        
        println(ball.physicsBody.velocity)
        
        return true
    }
    
    func restart () {
        let mainScene = CCBReader.loadAsScene("MainScene")
        CCDirector.sharedDirector().replaceScene(mainScene)
    }
    
    override func update(delta: CCTime) {
        
        if ball.position.x > width && gameOver == false {
            println("GameOver")
            restartButton.visible = true
            gameOver = true
        }
        else if ball.position.x < 0 && gameOver == false {
            println("GameOver")
            restartButton.visible = true
            gameOver = true
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