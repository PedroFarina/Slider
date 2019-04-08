import SpriteKit

open class Drawing : GameState{
    public var Scene: GameScene
    
    private var camera:SKCameraNode!
    public init(Scene:GameScene){
        self.Scene = Scene
        
        camera = SKCameraNode()
        Scene.addChild(camera)
        camera.position = CGPoint(x: Scene.size.width/2, y: Scene.size.height/2)
        Scene.camera = camera
        
        Scene.backgroundColor = .white
        btnChange = Button(Text: "Acceleration")
        btnChange!.position = CGPoint(x: -Scene.size.width/10 * 2, y: Scene.size.height/10 * 4)
        btnChange!.backgroundColor = .green
        
        btnErase = Button(Text: "Reset")
        btnErase!.position = CGPoint(x: Scene.size.width/10 * 2, y: Scene.size.height/10 * 4)
        btnErase!.backgroundColor = .white
        
        
        //camera.setScale(2)
        
        camera.addChild(btnChange!)
        camera.addChild(btnErase!)
        lineType = LineStyle.Normal
    }
    
    public var btnErase:Button?
    public var btnChange:Button?
    private var btnClick:Bool = false
    
    public var lineType:LineStyle{
        didSet{
            if(lineType == LineStyle.Normal){
                btnChange?.backgroundColor = .green
                btnChange?.Text = "Acceleration"
            }
            else{
                btnChange?.backgroundColor = .gray
                btnChange?.Text = "Normal Line"
            }
        }
        
    }
    
    private var initialPos : CGPoint!
    private var currentPos : CGPoint!{
        didSet{
            if let cPath = currentPath {
                cPath.addLine(to: currentPos)
            }
        }
    }
    
    public var currentPath:CGMutablePath?
    public var seeNode:Line!
    
    public func handleTouchDown(atPoint pos : CGPoint) -> GameState?{
        currentPath = CGMutablePath.init()
        currentPath!.move(to: pos)
        seeNode = Line(Path: currentPath!)
        if(checkButtons(atPoint: pos)){
            btnClick = true
        }
        initialPos = pos
        currentPos = pos
        //camera.run(zoomInAction)
        return nil
    }
    
    public func handleTouchMoved(atPoint pos : CGPoint) -> GameState?{
        currentPos = pos
        if let node = seeNode{
            node.path = currentPath
            if(node.parent == nil){
                Scene.addChild(node)
            }
        }
        return nil
    }
    
    open func handleTouchUp(atPoint pos : CGPoint) ->GameState?{
        if pos != initialPos{
            if let node = seeNode{
                if node.parent != nil{
                    node.removeFromParent()
                }
            }
            createLine()
        }
        else{
            if(!btnClick){
              return Playing(Scene: Scene, pos: pos)
            }
        }
        currentPath = nil
        btnClick = false
        return nil
    }
    
    deinit {
        btnErase?.removeFromParent()
        btnChange?.removeFromParent()
        camera.removeFromParent()
    }
}

extension Drawing{
    public enum LineStyle{
        case Normal
        case Acceleration
    }
    public func createLine(){
        if let path = currentPath{
            var shape:Line!
            switch lineType{
            case .Normal:
                    shape = NormalLine(Path:path)
            case .Acceleration:
                    shape = AccelerationLine(Path: path)
            }
            Scene.addChild(shape)
        }
    }
    
    public func checkButtons(atPoint pos:CGPoint) -> Bool{
        let nodes = Scene.nodes(at: pos)
        
        if let btnChange = self.btnChange{
            if nodes.contains(btnChange){
                if(lineType == LineStyle.Acceleration){
                    lineType = LineStyle.Normal
                }
                else{
                    lineType = LineStyle.Acceleration
                }
                return true
            }
        }
        
        if let btnErase = self.btnErase{
            if nodes.contains(btnErase){
                for node in Scene.children{
                    if let line = node as? Line{
                        line.removeFromParent()
                    }
                }
                return true
            }
        }
        
        return false
    }
}
