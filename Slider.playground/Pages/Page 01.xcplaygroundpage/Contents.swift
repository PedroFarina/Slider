
//#-hidden-code
import PlaygroundSupport
let Scene = Singleton.instance.Scene
PlaygroundSupport.PlaygroundPage.current.liveView = Singleton.instance.View
let world = Playing01(Scene: Scene)
Scene.setState(world)
//#-code-completion(everything, hide)
//#-end-hidden-code

/*:

 Gravity.

 When we talk about gravity we talk about atraction.

 It means that a body attract other bodies just by existing.

 Through this playground you'll experience physics through the eyes of Mike, a circle shaped monster.

![Mike Image](Mike/mikeClosing00.png)

 Mike since birth always wanted to be an astronaut.
 
 He dreams about beign in outter space and just falling back to earth. Thinking of how earth just pulls him back.
 
 You can adjust the pull force of Earth so it pushes Mike according to the number
*/

world.pullForce = /*#-editable-code Pull force of Earth*/10/*#-end-editable-code*/
