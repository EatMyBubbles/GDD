import Foundation

class MainScene: CCNode, CCPhysicsCollisionDelegate {
    
    weak var ball: CCSprite!
    weak var rightPaddle: Paddle!
    weak var leftPaddle: Paddle!
    weak var gamePhysicsNode: CCPhysicsNode!
    
    var width = CCDirector.sharedDirector().viewSize().width
    var gameOver: Bool = false
//    var speed: Double = 1
    var ballSpeed = 1
    
    
    
    func didLoadFromCCB() {
        multipleTouchEnabled = true
        userInteractionEnabled = true
        gamePhysicsNode.collisionDelegate = self
        
        ballPush()
//        physicsWorld.speed = ballSpeed
        
    }
    
    func ballPush() {
        var ballX = CGFloat(arc4random() % 2)
        var ballY = CGFloat(arc4random() % 2)
        
        if ballX == 0 {
            ball.physicsBody.velocity.x = 100
        } else {
            ball.physicsBody.velocity.x = -100
        }
        
        if ballY == 0 {
            ball.physicsBody.velocity.y = 50
        } else {
            ball.physicsBody.velocity.y = -50
        }
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, ball nodeA: CCNode!, paddle nodeB: CCNode!) -> Bool {
        
        
            leftPaddle.physicsBody.elasticity += 0.1
            rightPaddle.physicsBody.elasticity += 0.1
            ball.physicsBody.elasticity += 0.1
       
        
        println(ball.physicsBody.density)
        println(ball.physicsBody.friction)
//
//        ball.physicsBody.velocity.x = ( ballX * CGFloat (speed))
//        ball.physicsBody.velocity.y = ( ballY * CGFloat (speed))
        
        return true
    }
    
    override func update(delta: CCTime) {

        if ball.position.x > width && gameOver == false {
            println("GameOver")
            gameOver = true
        }
        else if ball.position.x < 0 && gameOver == false {
            println("GameOver")
            gameOver = true
        }
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
