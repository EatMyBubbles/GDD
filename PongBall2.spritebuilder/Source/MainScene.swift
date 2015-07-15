import Foundation

class MainScene: CCNode {
    
    weak var Ball: CCSprite!
    weak var rightPaddle: CCSprite!
    weak var leftPaddle: CCSprite!
    weak var gamePhysicsNode: CCPhysicsNode!
    
    var width = CCDirector.sharedDirector().viewSize().width
    
    func didLoadFromCCB() {
        
        //multipleTouchEnabled = true
        userInteractionEnabled = true
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        var touchLocationY = touch.locationInNode(CCPhysicsNode()!).y
        
        println(touchLocationY)
    }
    
    override func touchMoved(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        var touchX = touch.locationInNode(CCPhysicsNode()!).x
        
        if touchX > width/2 {
            rightPaddle.positionInPoints.y = touch.locationInNode(CCPhysicsNode()!).y
        }
        else {
            leftPaddle.positionInPoints.y = touch.locationInNode(CCPhysicsNode()!).y
        }
        
        println(touch.locationInNode(CCPhysicsNode()!).y)
    }
}
