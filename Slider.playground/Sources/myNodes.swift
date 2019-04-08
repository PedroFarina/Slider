import PlaygroundSupport
import SpriteKit

public let playerMask:UInt32 = 0x1
public let lineNormMask:UInt32 = 0x1 << 1
public let lineAcceMask:UInt32 = 0x1 << 2
public let lineDrawMask:UInt32 = 0x1 << 3
public let eraserMask:UInt32 = 0x1 << 4
public let earthMask:UInt32 = 0x1 << 5
public let targetMask:UInt32 = 0x1 << 6

public enum Side:CGFloat{
    case Left = -1.0
    case Right = 1.0
}

open class PhysicsSpriteNode:SKNode{
    public var Image:SKSpriteNode
    
    public init(imageNamed : String, scale : CGFloat){
        Image = SKSpriteNode(imageNamed: imageNamed)
        super.init()
        self.name = "PhysicsSprite"
        
        self.setScale(scale)
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: imageNamed), size: CGSize(width: Image.size.width * scale, height: Image.size.height * scale))
        self.addChild(Image)
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("This node doesn't support coder.")
    }
}


public class Player : PhysicsSpriteNode{
    let scale:CGFloat = 0.05
    var images:[SKTexture] = [SKTexture]()
    public var oneSideOnly:Side?
    
    convenience init(imageNamed : String){
        self.init(imageNamed:imageNamed, images:[SKTexture]())
    }
    
    public init(imageNamed:String, images:[SKTexture]){
        super.init(imageNamed: imageNamed, scale: scale)
        self.name = "Player"
        self.physicsBody!.categoryBitMask = playerMask
        self.physicsBody!.collisionBitMask = lineNormMask | lineAcceMask | playerMask | earthMask
        self.physicsBody!.contactTestBitMask = lineAcceMask
        
        self.physicsBody!.charge = 1
        self.images = images
    }
    
    public func runAnimation(){
        if(images.count > 0){
            Image.run(SKAction.animate(with: images, timePerFrame: 0.1, resize: true, restore: true))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This node doesn't support coder.")
    }
}

public class Eraser:PhysicsSpriteNode{
    public init(imageNamed : String){
        super.init(imageNamed : imageNamed, scale :1)
        self.name = "Eraser"
        
        self.physicsBody!.categoryBitMask = eraserMask
        self.physicsBody!.contactTestBitMask = lineNormMask | lineAcceMask
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This node doesn't support coder.")
    }
}

public class Line : SKShapeNode{
    init(Path:CGPath){
        super.init()
        self.name = "line"
        self.path = Path
        self.strokeColor = .gray
        self.lineWidth = 2
        self.physicsBody = SKPhysicsBody(edgeChainFrom: Path)
        self.physicsBody!.collisionBitMask = playerMask
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This node doesn't support coder.")
    }
}

public class NormalLine : Line{
    override init(Path: CGPath) {
        super.init(Path:Path)
        self.name = "normLine"
        self.strokeColor = .black
        self.physicsBody!.categoryBitMask = lineNormMask
        self.physicsBody!.collisionBitMask = playerMask
        self.physicsBody!.contactTestBitMask = 0x0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This ndoe doesn't support coder.")
    }
}

public class AccelerationLine:Line{
    override init(Path: CGPath) {
        super.init(Path: Path)
        self.name = "acceLine"
        self.strokeColor = .green
        self.physicsBody!.categoryBitMask = lineAcceMask
        self.physicsBody!.collisionBitMask = playerMask
        self.physicsBody!.contactTestBitMask = playerMask
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This node doesn't support coder.")
    }
}

public class Button:SKNode{
    
    private var myFrame: SKShapeNode!
    private var lbl : SKLabelNode
    init(Text:String){
        lbl = SKLabelNode(text: Text)
        lbl.fontColor = .black
        lbl.fontSize = 14
        super.init()
        
        makeFrame(color: UIColor.white)
        
        self.addChild(myFrame)
        self.addChild(lbl)
    }
    
    private func makeFrame(color: UIColor){
        myFrame = SKShapeNode(rect: CGRect(x: 0, y: 0, width: lbl.frame.width + 10, height: lbl.frame.height + 6))
        myFrame.strokeColor = .black
        myFrame.fillColor = color
        myFrame.position = CGPoint(x: lbl.position.x - 5 - lbl.frame.width/2, y: lbl.position.y - 3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This node doesn't support coder.")
    }
    
    public var Text:String?{
        get{
            return lbl.text
        }
        set{
            lbl.text = newValue
            //makeFrame(color:myFrame.fillColor)
        }
    }
    
    public var backgroundColor:UIColor{
        get {
            return myFrame.fillColor
        }
        set{
            myFrame.fillColor = newValue
        }
    }
}
