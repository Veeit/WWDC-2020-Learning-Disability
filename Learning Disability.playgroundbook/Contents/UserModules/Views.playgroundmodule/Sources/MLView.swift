import SwiftUI
import PlaygroundSupport
import CoreML
import PencilKit
import Vision
import SwiftUI
import PencilKit
import MlModel

public struct MlView: View {
    let canvas = CanvasRepresentation()
    private let textRecognitionWorkQueue = DispatchQueue(label: "VisionRequest", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    
    @State var text = ""
    @ObservedObject var data: LetterModel
    
    
    /*public init(data: LetterModel) {
        self.data = data
    }*/
    
    public init(option: [Any]) {
        self.data = LetterModel(option: option)
    }
    
    //public init() {}
    
    public var body: some View {
        VStack() {
            if (self.data.correctString != "") {
                HStack() {
                    Group() {
                        Text("Your word to write is: ")
                            .fontWeight(.bold) +
                            Text(self.data.correctString)
                    }.font(.system(.largeTitle, design: .rounded))
                }
            }
            
            HStack() {
                if (self.data.letters.count != 0) {
                    ForEach(self.data.letters) { letter in
                        letterView(letter: letter)
                            .onTapGesture {
                                self.data.toggleLetter(letter: letter)
                        }
                        .gesture(
                            LongPressGesture(minimumDuration: 1)
                                .onEnded { _ in
                                    let index = self.data.letters.firstIndex(of: letter)
                                    if (index != nil) {
                                        self.data.letters.remove(at: index!)
                                    }
                            }
                        )
                    }
                } else {
                    ForEach(self.data.defaultLetters) { letter in
                        letterView(letter: letter)
                    }
                }
            }.animation(.easeInOut(duration: 0.5))
            
            canvas
                .frame(width: self.text != "" ? 350 : 370, height: self.text != "" ? 350 : 370)
                //.frame(width: 400, height: 400)
                .background(Color.white)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.blue, lineWidth: 4)
                )
                .animation(.easeInOut(duration: 0.5))
                .padding([.bottom])
            
            HStack() {
                Button(action: {
                    let image = self.canvas.canvas.getImage()
                    self.recognize(image)
                }){
                    Text("Determine")
                    .foregroundColor(Color.white)
                }
                    .padding([.top,.bottom], 10)
                    .padding([.leading, .trailing], 15)
                    .background(Color.accentColor)
                    .cornerRadius(6)
                .animation(.easeInOut(duration: 0.5))
                //.buttonStyle(mlButtonStyle(color: .accentColor))
                
                Spacer()
                Button(action: {
                    self.canvas.canvas.clear()
                    self.text = ""
                }){
                    Text("Clear")
                    .foregroundColor(Color.white)
                }
                .padding([.top,.bottom], 10)
               .padding([.leading, .trailing], 15)
               .background(Color.red)
               .cornerRadius(6)
                .animation(.easeInOut(duration: 0.5))
                //.buttonStyle(mlButtonStyle(color: .red))
                
            }.frame(width: 400)
                .padding([.bottom])
            
            if self.text != "" {
                Button(action: {
                    self.data.checkString(checkLetter: self.text)
                    self.canvas.canvas.clear()
                    self.text = ""
                    
                }){
                    Text("Add to Word")
                    .foregroundColor(Color.white)
                }
                //.buttonStyle(mlButtonStyle(color: .green))
                    .padding([.top,.bottom], 10)
                    .padding([.leading, .trailing], 15)
                    .background(Color.green)
                    .cornerRadius(6)
                .frame(width:400)
                .padding([.bottom], 20)
                .animation(.easeInOut(duration: 0.5))
                
                Group() {
                    Text("Determined Letter: ")
                        .fontWeight(.bold) +
                    Text(self.text)
                }.font(.system(.largeTitle, design: .rounded))
                
                
            }
        }
    }
    
    // Setup the recognize function
    func recognize(_ image: UIImage) {
        recognizer.recognize(image) {
            result in
            switch (result) { // check if the succesed
            case .success(let prediction):
                print(prediction.letter)
                text = prediction.letter
            case .error(let message):
                print(message)
            }
        }
    }
    
    struct letterView: View {
        var letter: letter
        var body: some View {
            Text(letter.name)
                .padding()
                .background(Color.secondary.opacity(0.6))
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(letter.right ? Color.blue : Color.red, lineWidth: 2)
                )
                .font(.system(.body, design: .rounded))
        }
    }
/*
    struct mlButtonStyle: ButtonStyle {
        var color: Color = .green
       
        public func makeBody(configuration: MyButtonStyle.Configuration) -> some View {
           configuration.label
               .padding([.top,.bottom], 10)
               .padding([.leading, .trailing], 15)
               .background(color)
               .cornerRadius(6)
               .animation(.easeInOut(duration: 0.5))
        }
    }
 */
 
}


