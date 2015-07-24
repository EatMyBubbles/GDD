import Foundation
//note to self: get the right friction amount
class MainScene: CCNode {
    
    func play() {
        let gameplayScene = CCBReader.loadAsScene("Gameplay")
        CCDirector.sharedDirector().presentScene(gameplayScene)
        
        
    }
    

}
