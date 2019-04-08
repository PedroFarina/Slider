import PlaygroundSupport
import SpriteKit
import UIKit

public class GameScene: SKScene, SKPhysicsContactDelegate {
    public var gravity:Double{
        didSet{
            physicsWorld.gravity = CGVector(dx: 0, dy: -gravity)
        }
    }
    public override init(size: CGSize)
    {
        gravity = 9.8
        super.init(size:size)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        gravity = 9.8
        super.init()
    }
    
    private var State:GameState!
    private var Pinch:Bool = false
    
    public override func sceneDidLoad() {
        State = Menu(Scene: self)
        physicsWorld.contactDelegate = self
        //view = SKView(frame: CGRect(x:0 , y:0, width: 100, height: 100))
        //frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        //size = CGSize(width: 100,`height: 100)
    }
    
    public override func didMove(to view: SKView) {
        let pinchGesture = UIPinchGestureRecognizer()
        pinchGesture.addTarget(self, action: #selector(pinchGestureAction(_:)))
        view.addGestureRecognizer(pinchGesture)
    }
    
    @objc func pinchGestureAction(_ sender: UIPinchGestureRecognizer) {
        Pinch = true
        guard let camera = self.camera else {
            return
        }
        let pinch = SKAction.scale(by: sender.scale, duration: 0.0)
        sender.scale = 1.0
        camera.run(pinch)
    }

    
    public func setState(_ newState:AnyObject){
        if let state = newState as? GameState{
            State = state
        }
    }
    
    /*public func teste(){
        view?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }*/

    public func didBegin(_ contact: SKPhysicsContact) {
        if let newState = State.didBegin(contact){
            State = newState
        }
    }
    
    public override func didChangeSize(_ oldSize: CGSize) {
        repositionAll(oldSize)
    }
    
    private func repositionAll(_ oldSize:CGSize){
        for obj in children{
            reposition(obj: obj, oldSize: oldSize)
        }
    }
    private func reposition(obj:SKNode, oldSize:CGSize){
        let newX = (obj.position.x * size.width) / oldSize.width
        let newY = (obj.position.y * size.height) / oldSize.height
        
        obj.position = CGPoint(x: newX, y: newY)
    }
    
    @objc static public override var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let newState = State?.handleTouchDown(atPoint: pos){
            State = newState
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let newState = State?.handleTouchMoved(atPoint: pos){
            State = newState
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let newState = State?.handleTouchUp(atPoint: pos){
            State = newState
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let wait:SKAction = SKAction.wait(forDuration: 1/10)
        let finishTimer:SKAction = SKAction.run {
            if(!self.Pinch){
                for t in touches { self.touchDown(atPoint: t.location(in: self)) }
            }
        }
        let seq:SKAction = SKAction.sequence([wait, finishTimer])
        self.run(seq)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let wait:SKAction = SKAction.wait(forDuration: 1/10)
        let finishTimer:SKAction = SKAction.run {
            if(!self.Pinch){
                for t in touches { self.touchMoved(toPoint: t.location(in: self))}
            }
        }
        let seq:SKAction = SKAction.sequence([wait, finishTimer])
        self.run(seq)
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let wait:SKAction = SKAction.wait(forDuration: 1/10)
        let finishTimer:SKAction = SKAction.run {
            if(!self.Pinch){
                for t in touches { self.touchUp(atPoint: t.location(in: self)) }
            }
            self.Pinch = false
        }
        let seq:SKAction = SKAction.sequence([wait, finishTimer])
        self.run(seq)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    public override func update(_ currentTime: TimeInterval) {
        if let newState = State?.update(currentTime){
            State = newState
        }
    }
}
