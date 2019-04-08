import SpriteKit


public class Playing03:Playing{
    open override func handleTouchUp(atPoint pos: CGPoint) -> GameState? {
        return Drawing03(Scene: Scene)
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
