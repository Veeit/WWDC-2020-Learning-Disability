/*:
 
 #  Learning your word

 First you need to find a word that you want to learn, you can use a generated word or define a custom one. The generated one will be picked from the Dolch word list, the list contains the most misspelt words from people with a learning disability.
 
  This playground uses a pre trained ML (machine learning) model that detects your handwritten letter, the ML is based on the EMNIST Dataset and is trained with more than 600.000 images. To create the ML I used Python with Keras and after training I converted it to a .mlmodel file. By using this process the ML only needs 550kb of space. The initial training files together were 8gb! I also created a version with CreateML but I archived much higher accuracy with the python version. The ML is a basic Image Classifer ML that just learned to classify all uppercase letters and numbers from 1 to 9.
 
Handwriting is still one of the best ways to train the muscle memory and you can't learn a word that you want to write without handwriting it at least once. To write each letter individual helps you the remember each letter currently. It is common that people with learning disability write words as they sound.
 */

/*:
## Code options

You have 3 Options for setting the word that you want to learn, you can change the used option in the code.

1. .Generate() will automatically pick a word for you
2. .Custom(word: “your word”) will set a custom word
3. .None don’t set any word, just type what you want
*/

/*:
 ## How to control this page.
 
- first draw an uppercase letter inside the canvas
 - you can clean the canvas with the clean button
 - to turn the handwritten letter into a typed letter, you have to press the determine button.
 - repeat this process until the word is complete
 - if one of the letters is wrong, it will turn red. To remove it press on it for 1 sec. (This won’t work, if you used option 3)
 - if you want to have a lower-case letter tap on it
 
 */

/*:
 - Important:
You need to create a word with the handwriting recognition, that is needed for the next page.
 */

//: [Build your memory palace with AR on the next page](@next)

import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    let option = configString(option: /*#-editable-code define your word*/.Generate/*#-end-editable-code*/)
    
    var body: some View {
        MlView(option: option)
    }
}

// Playground
PlaygroundPage.current.setLiveView(ContentView())
