import SpriteKit

open class Target:PhysicsSpriteNode{
    public init(imageNamed : String){
        super.init(imageNamed: imageNamed, scale: 0.2)
        self.name = "Target"
        
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.categoryBitMask = targetMask
        self.physicsBody!.collisionBitMask = 0x0
        self.physicsBody!.contactTestBitMask = playerMask
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("This node doesn't support coder.")
    }
}
