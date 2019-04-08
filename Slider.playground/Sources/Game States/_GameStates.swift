import SpriteKit

public protocol GameState{
    func handleTouchDown(atPoint pos : CGPoint) -> GameState?
    func handleTouchMoved(atPoint pos : CGPoint) -> GameState?
    func handleTouchUp(atPoint pos : CGPoint) -> GameState?
    func didBegin(_ contact: SKPhysicsContact) -> GameState?
    func update(_ currentTime : TimeInterval) -> GameState?
    var Scene:GameScene {get set}
}

extension GameState{
    public func handleTouchDown(atPoint pos : CGPoint) -> GameState?{
        return nil
    }
    public func handleTouchMoved(atPoint pos: CGPoint) -> GameState? {
        return nil
    }
    
    public func handleTouchUp(atPoint pos: CGPoint) -> GameState? {
        return nil
    }
    
    public func didBegin(_ contact: SKPhysicsContact) -> GameState? {
        return nil
    }
    
    public func update(_ currentTime: TimeInterval) -> GameState? {
        return nil
    }
}

public let zoomInAction = SKAction.scale(by: 0.5, duration: 1)
public let zoomOutAction = SKAction.scale(by: 2, duration: 1)
public let fadeInOut = SKAction.sequence([.fadeIn(withDuration: 1.2),
                                   .fadeOut(withDuration: 1.2)])
