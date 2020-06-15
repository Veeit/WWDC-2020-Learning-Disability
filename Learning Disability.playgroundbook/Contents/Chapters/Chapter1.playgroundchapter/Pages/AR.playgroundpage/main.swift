/*:
 #  Build your memory palace 🧠
 
 Do you know Schlerock Holems ? Maybe he is the most known person that useses a memory palace. The methord to member things with the help of a memeory palace is a also known as the "Method of loci" and was first described in 1966.
 
 ## But what is a memory palace ?
 
The Memorial Palace is a place you make up your own mind. It can be every thing, for example your office. Inside your palace you can create rooms for each object that you want to remember. The goal is that you visulise thise things. It is proven that you remeber images better than written things, espacily for some one with learning disability. The old method to get started with visualie things is with clay.
 
 ## Therapy for people with learnning disability
 
 It is a well known therapy for people with lerning disability to create a picture with clay for it, for example a Person is before a table. The word is before. They also need to write the word with clay and put it to the picture. That needs to rember the word and how it is written. The closed expirance that I could build is with the handwriting recognition on page 2 and this AR scene. I have used the clay therapy and it helped me a lot to improve my writing.
 
 ## Build a memory palace with AR 🧱
 
With modern technologie we can visulise the memory palace with AR, I created a a floating island as your memory palace. You can pick different object and arange them like you want to visulise your word. I will use the word that you wrote on page 2 to as Text. Because we are creating a 3D object that usaly has a clear perspective to look at it we can solve the issue from page 1 with it. The person can new look at the object and can see where the front is and from where he needs to look to write the word correctly.
  
 */

/*:
 - Important:
 you should place your word as text on the island to keep conncet it inside your meomry with your image.
 */

/*:
  ### Tips for AR:
 
 - The most important thing is that you get up and move around to play with the AR. That does not only help you to build your island that also helps you to keep you island in memory.
 
 - close every video that is playing inside picutre in picture mode, if you don't do that the screen will be black.

 - please not use the full screen mode, this creashes somethimes the playground.
 
 - have some distance beween your and the island (around 3 foot). The Raycasting (object positon) works than best.
 
 */
/*:
 ### Your Tasks:
1. Build your "room" on the island to visulise your word.
2. Add the word as text to the "room"
3. Turn on repeatScene to build your island again to keep it better in memeory.
 */

/*:
 - Note:
  I wanted to have a more raycast tracking but it creashed the playground. That is why you new need to move the object to the exact location after you added it to the scene.
  \
  Also I needed to create every model with Blender and Vectory my self, every model that I found online is to big for a playground and it crashes immediately. It is the first time that I created 3D assets my self. Because of this the models are not very complicated what is perfect for a playground 😁.
*/

import PlaygroundSupport
import SwiftUI

// SwiftUI
struct ContentView: View {
    @ObservedObject var ARData = ARViewData()
    
    var body: some View {
        ARView(ARData: ARData)
        .onAppear(perform: {
            self.ARData.repeatScene = /*#-editable-code turn to repeat the sene*/false/*#-end-editable-code*/
        })
    }
}

// Playground
PlaygroundPage.current.setLiveView(ContentView())
PlaygroundPage.current.needsIndefiniteExecution = true

/*:
 - Note:
 I hope you liked my playground and you have learned some thing new. Say inside and healthy.
 */
