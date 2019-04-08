import SpriteKit


public class Playing04:Playing{
    public override init(Scene: GameScene, pos: CGPoint) {
        super.init(Scene: Scene, pos: pos)
        playerNode.oneSideOnly = .Left
    }
    
    open override func handleTouchUp(atPoint pos: CGPoint) -> GameState? {
        return Drawing04(Scene: Scene)
    }
    
    open override func didBegin(_ contact: SKPhysicsContact) -> GameState? {
        let state = super.didBegin(contact)
        if (contact.bodyA.node?.name == "Target" || contact.bodyB.node?.name == "Target") {
            if(contact.bodyB.node?.name == "Player" || contact.bodyA.node?.name == "Player"){
                Scene.isPaused = true
            }
        }
        return state
    }
    
    deinit {
        Scene.isPaused = false
    }
}
