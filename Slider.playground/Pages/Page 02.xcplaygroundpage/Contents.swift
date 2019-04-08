//#-hidden-code
import PlaygroundSupport
let Scene = Singleton.instance.Scene
PlaygroundSupport.PlaygroundPage.current.liveView = Singleton.instance.View

Scene.setState(Drawing02(Scene: Scene))
//#-code-completion(everything, hide)
//#-end-hidden-code

/*:
 In this page you'll learn the basic interactions on the game. It'll carry on to the other pages.

![Mike on Fire](mikeFalling.png)
 
 Mike is entering the orbit and needs your help stoping before reaching the ground.
*/
