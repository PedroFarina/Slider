//#-hidden-code
import PlaygroundSupport
let Scene = Singleton.instance.Scene
PlaygroundSupport.PlaygroundPage.current.liveView = Singleton.instance.View
Scene.setState(Drawing04(Scene: Scene))
//#-code-completion(everything, hide)
//#-end-hidden-code
/*:
 Class is over. Mike will need your help getting home.
 In this page you'll learn how to use the green acceleration line.
 
 Notice that if your path has no curves your acceleration might not be enough to get home.
*/
