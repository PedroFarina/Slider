import SpriteKit

open class Menu : GameState{
    public var Scene: GameScene
    public init(Scene:GameScene){
        self.Scene = Scene
        labelInstruction = Menu.generateInstructionLabel()
        labelInstruction.position = CGPoint(x: Scene.frame.width/2, y: Scene.frame.height/2)
        Scene.addChild(labelInstruction)
        //Scene.backgroundColor = .black
    }
    var labelInstruction:SKLabelNode
    
    public func handleTouchUp(atPoint pos: CGPoint) -> GameState? {
        return Drawing(Scene: Scene)
    }
    
    deinit {
        labelInstruction.removeFromParent()
    }
}

extension Menu{
    public static func generateInstructionLabel() -> SKLabelNode{
        let lblInstruction = SKLabelNode(text: "Touch the screen to begin playing.")
        lblInstruction.fontSize = 28
        lblInstruction.run(.repeatForever(fadeInOut))
        return lblInstruction
    }
}
