import Foundation
import SpriteKit

class Earth:PhysicsSpriteNode{
    let fieldNode = SKFieldNode.radialGravityField()
    init(imageNamed:String){
        super.init(imageNamed: imageNamed, scale:0.5)
        self.name = "Earth"
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.categoryBitMask = earthMask
        self.physicsBody!.collisionBitMask = 0x0
        self.physicsBody!.contactTestBitMask = playerMask
        
        fieldNode.position = self.position
        fieldNode.strength = 500
        self.addChild(fieldNode)
    }
    public var strength:Float{
        get{
            return fieldNode.strength
        }
        set{
            fieldNode.strength = newValue
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Node doesn't support coder")
    }
}
