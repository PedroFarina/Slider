import SpriteKit

public class Drawing03 : Drawing{
    let guide = GuideLine()
    let school = Target(imageNamed: "School.png")
    let house:SKSpriteNode = SKSpriteNode(imageNamed: "House.png")
    let mountain01:SKSpriteNode = SKSpriteNode(imageNamed: "Mountain01.png")
    let mountain02:SKSpriteNode = SKSpriteNode(imageNamed: "Mountain02.png")
    let lblInstrucions:SKLabelNode = SKLabelNode(text: "Single tap with your finger anywhere on the screen to play.")
	
    public override init(Scene: GameScene) {
        super.init(Scene: Scene)
        btnChange?.removeFromParent()
        btnChange = nil
        
        guide.position = CGPoint(x: Scene.size.width/2, y: Scene.size.height/10 * 4.2)
        guide.zRotation = 11*3.14/6
        school.position = CGPoint(x:Scene.size.width/10 * 7.5, y:Scene.size.height/10 * 3)
        
        house.position = CGPoint(x: Scene.size.width/10 * 2.5, y: Scene.size.height/10 * 6.3)
        house.setScale(0.2)
        
        mountain01.position = school.position
        mountain01.setScale(0.2)
        mountain01.position.y -= 75
        mountain01.position.x += 80
        mountain01.zPosition = -1
        
        mountain02.position = house.position
        mountain02.setScale(0.2)
        mountain02.position.y -= 280
        mountain02.position.x -= 75
        mountain02.zPosition = -1
		
		lblInstrucions.fontSize = 14
        lblInstrucions.fontColor = .black
        lblInstrucions.position = CGPoint(x: Scene.size.width/2, y: Scene.size.height/10 * 8)
        
        Scene.addChild(mountain01)
        Scene.addChild(mountain02)
        Scene.addChild(house)
        Scene.addChild(school)
        Scene.addChild(guide)
    }
    
    open override func handleTouchUp(atPoint pos: CGPoint) -> GameState? {
        if let nextState = super.handleTouchUp(atPoint: pos){
            if let _ = nextState as? Playing{
                return Playing03(Scene:Scene, pos: CGPoint(x: Scene.size.width/10 * 2.9 + 15, y: Scene.size.height/10 * 6.2 + 90))
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
		if lblInstrucions.parent != nil{
			lblInstrucions.removeFromParent()
		}
    }
}
