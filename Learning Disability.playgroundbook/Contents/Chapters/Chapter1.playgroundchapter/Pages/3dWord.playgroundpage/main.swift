/*:
 # What is learning disability?
 
  Learning disability is a condition in the brain that causes difficulties comprehending or processing information and can be caused by several different factors. It includes reading (dyslexia), arithmetic (dyscalulia) and writing (dysgraphia) disorders.

 The brain of an individual with learning disability is structured differently than a normal brain, which means it can't be cured. But by undergoing different therapies or doing different exercises you can learn to deal with it.
  
  Individuals with learning disabilities can face unique challenges that are often pervasive throughout the lifespan.
  
[Source and more information at wikipedia](https://en.wikipedia.org/wiki/Learning_disability)
  
 People with learning disability actually have other skills that are stronger, most people can think better in 3-dimensional space.
 I'm one the individuals with learning disability, and I found a way to use it for my advantage.
 
 ---

 First imagine that you are one of the individuals with a learning disability. Which means that you see every letter in a 3-Dimensional space that which enables you to rotate it in front of your inner eye. How does a b look like to you now? Is it still a b or is it a d? Exactly, you can't tell because it depends of the rotation of the letter in the 3D space.

 
 On this page you can see any letter in 3D space and experience the problem yourself.
 */

//: [Next page](@next)

import PlaygroundSupport
import SwiftUI

struct contentView: View {
    var body: some View {
        VStack() {
            Letter3dRepresentation(text: /*#-editable-code letter to view in 3D*/"b"/*#-end-editable-code*/)
        }
    }
}

PlaygroundPage.current.setLiveView(contentView())
