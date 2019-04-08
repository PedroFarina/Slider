import SpriteKit

public class ArchGuideLine:SKNode{
    let arch:SKShapeNode
    let lblInstruction:SKLabelNode
    public override init(){
        lblInstruction = SKLabelNode(text: "Draw this shape with your finger.")
        arch = SKShapeNode()
        super.init()
        let myPath:CGMutablePath = CGMutablePath.init()
        
        myPath.addArc(center: CGPoint(x: 0, y: 0), radius: 50, startAngle: 0, endAngle: 3.14, clockwise: true)
        arch.path = myPath
        arch.strokeColor = .black
        arch.lineWidth = 2
        
        lblInstruction.fontSize = 14
        lblInstruction.fontColor = .black
        lblInstruction.position = arch.position
        lblInstruction.position.y = arch.frame.height
        
        self.addChild(arch)
        self.addChild(lblInstruction)
        self.run(SKAction.repeatForever(fadeInOut))
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Node doesn't support coder")
    }
}
