import SpriteKit

open class Playing01:Playing{
    let earth:Earth = Earth(imageNamed: "earth.png")
    public init(Scene:GameScene){
        pullForce = 140
        super.init(Scene: Scene, pos: CGPoint(x:Scene.size.width/2, y:Scene.size.height))
        earth.position.x = Scene.size.width/2
        Scene.addChild(earth)
        Scene.physicsWorld.gravity = CGVector(dx:0, dy:0)
        generateStars()
    }
    
    private func generateStars(){
        for _ in 0...Int.random(in: 15...25){
            let star:SKSpriteNode = SKSpriteNode(imageNamed: "Star.png")
            star.name = "star"
            star.setScale(0.15)
            star.zPosition = -1
            let randX = Int(Float.random(in: 40...Float(Scene.size.width)))
            let randY = Int(Float.random(in: Float(Scene.size.height/3)...Float(Scene.size.height/10 * 9)))
            
            star.position = CGPoint(x:randX, y:randY)
            Scene.addChild(star)
        }
    }
    
    public var pullForce:Float{
        didSet{
            earth.strength = pullForce * 5
        }
    }
    open override func handleTouchUp(atPoint pos: CGPoint) -> GameState? {
        return nil
    }
    
    deinit {
        for node in Scene.children{
            if node.name == "star"{
                node.removeFromParent()
            }
        }
        Scene.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
    }
}
