//#-hidden-code
import PlaygroundSupport
let Scene = Singleton.instance.Scene
PlaygroundSupport.PlaygroundPage.current.liveView = Singleton.instance.View
Scene.setState(Menu(Scene: Scene))
//#-code-completion(everything, hide)
//#-end-hidden-code

/*:
 Thanks for accompaning Mike through his day!
 
 If you want to, you can keep drawing paths to Mike to follow.
 
 This page was designed to be a sandbox mode for you to play around.
*/
