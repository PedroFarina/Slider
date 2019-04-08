import SpriteKit

open class GuideLine:SKNode{
    let line:SKShapeNode
    let lblInstruction:SKLabelNode
    public override init(){
        lblInstruction = SKLabelNode(text: "Draw this shape with your finger")
        line = SKShapeNode()
        super.init()
        
        let myPath:CGMutablePath = CGMutablePath.init()
        
        let halfSize = 230
        myPath.move(to: CGPoint(x: -halfSize, y: 0))
        myPath.addLine(to: CGPoint(x: halfSize, y: 0))
        line.path = myPath
        line.strokeColor = .black
        line.lineWidth = 2
        
        lblInstruction.fontSize = 14
        lblInstruction.fontColor = .black
        lblInstruction.position = line.position
        lblInstruction.position.y = line.frame.height
        
        self.addChild(line)
        self.addChild(lblInstruction)
        self.run(SKAction.repeatForever(fadeInOut))
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Node doesn't support coder")
    }
}
