import SpriteKit

open class Singleton{
    public static let instance = Singleton()
    private init(){
        View = SKView(frame: CGRect(x:0 , y:0, width: 960, height: 720))
        Scene = GameScene(size:CGSize(width: View.frame.width, height: View.frame.height))
        Scene.scaleMode = .aspectFill
        View.presentScene(Scene)
    }
    public var View:SKView
    public var Scene:GameScene
}
