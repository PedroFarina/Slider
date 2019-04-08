import SpriteKit

public class Drawing02:Drawing{
    let guide:ArchGuideLine = ArchGuideLine()
    let lblInstrucions:SKLabelNode = SKLabelNode(text: "Single tap anywhere on the screen to test your barrier.")
    
    public override init(Scene: GameScene) {
        super.init(Scene: Scene)
        btnChange?.removeFromParent()
        btnChange = nil
        
        btnErase?.removeFromParent()
        btnErase = nil
        
        guide.position = CGPoint(x: Scene.size.width/2, y: Scene.size.height/10 * 7)
        Scene.addChild(guide)
        
        lblInstrucions.fontSize = 14
        lblInstrucions.fontColor = .black
        lblInstrucions.position = CGPoint(x: Scene.size.width/2, y: Scene.size.height/10 * 8)
    }
 
    open override func handleTouchUp(atPoint pos: CGPoint) -> GameState? {
        if let nextState = super.handleTouchUp(atPoint: pos){
            if let _ = nextState as? Playing{
                return Playing02(Scene:Scene, pos: CGPoint(x: Scene.size.width/2, y: Scene.size.height))
            }
            return nextState
        }
        else{
            if lblInstrucions.parent == nil{
                Scene.addChild(lblInstrucions)
                lblInstrucions.run(SKAction.scale(by: 1.2, duration: 0.5))
                guide.removeFromParent()
            }
        }
        return nil
    }
    
    deinit {
        guide.removeFromParent()
        lblInstrucions.removeFromParent()
    }
}
