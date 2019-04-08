import SpriteKit

open class Playing : GameState{
    public var Scene: GameScene
    public var playerNode: Player
    public var camera : SKCameraNode
    public init(Scene:GameScene, pos:CGPoint){
        self.Scene = Scene
        playerNode = Playing.generatePlayer()
        playerNode.position = pos
        Scene.addChild(playerNode)
        playerNode.runAnimation()
        camera = SKCameraNode()
        Scene.addChild(camera)
        Scene.camera = camera
    }
    static let myTextures:[SKTexture] = [SKTexture(imageNamed: "Mike/mikeClosing00.png"), SKTexture(imageNamed: "Mike/mikeClosing01.png"), SKTexture(imageNamed: "Mike/mikeClosing02.png"), SKTexture(imageNamed: "Mike/mikeClosing03.png"), SKTexture(imageNamed: "Mike/mikeClosing04.png"), SKTexture(imageNamed: "Mike/mikeClosing05.png"), SKTexture(imageNamed: "Mike/mikeClosing06.png")]
    open func handleTouchUp(atPoint pos: CGPoint) -> GameState? {
        return Drawing(Scene: Scene)
    }
    
    open func didBegin(_ contact: SKPhysicsContact) -> GameState? {
        switch contact.bodyA.categoryBitMask {
        case lineAcceMask:
            var acc = contact.bodyB.velocity
            if let side = playerNode.oneSideOnly {
                acc.dx = (abs(acc.dx) + 480) * side.rawValue
                
            }
            acc.dx = acc.dx/120
            acc.dy = acc.dy/120
            contact.bodyB.applyImpulse(acc, at: contact.contactPoint)
        default:
            break
        }
        
        return nil
    }
    
    open func update(_ currentTime: TimeInterval) -> GameState? {
        camera.position = playerNode.position
        return nil
    }
    
    deinit {
        camera.removeFromParent()
        playerNode.removeFromParent()
    }
}

extension Playing{
    public static func generatePlayer() -> Player{
        let playerNode = Player(imageNamed: "Mike/mikeClosed.png", images: myTextures)
        return playerNode
    }
}
