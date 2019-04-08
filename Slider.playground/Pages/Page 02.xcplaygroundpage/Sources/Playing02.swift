import SpriteKit

public class Playing02:Playing
{
    let lblInstructions:SKLabelNode
    public override init(Scene: GameScene, pos: CGPoint) {
        lblInstructions = SKLabelNode(text: "Tap anywhere on the screen to end your test.")
        super.init(Scene: Scene, pos: pos)
        
        lblInstructions.fontColor = .black
        lblInstructions.fontSize = 15
        Scene.addChild(lblInstructions)
    }
    
    open override func handleTouchUp(atPoint pos: CGPoint) -> GameState? {
        return Drawing02(Scene: Scene)
    }
    
    open override func update(_ currentTime: TimeInterval) -> GameState? {
        let state = super.update(currentTime)
        lblInstructions.position.x = playerNode.position.x
        lblInstructions.position.y = playerNode.position.y + Scene.size.height / 5
        return state
    }
    
    deinit {
        lblInstructions.removeFromParent()
    }
}
