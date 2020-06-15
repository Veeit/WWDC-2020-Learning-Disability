import PlaygroundSupport
import SwiftUI
import RealityKit
import ARKit
import ARModule

public struct ARView: View {
    @ObservedObject var ARData: ARViewData
    
    public init(ARData: ARViewData) {
        self.ARData = ARData
    }
    
    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ARViewWrapper(ARData: ARData)
            
            if self.ARData.repeatScene {
                VStack() {
                    LeftObjects(keys: Array(self.ARData.AllObjets.keys), dict: ARData.AllObjets)
                    Spacer()
                }
            }
            
            ModelPicker(ARData: ARData)
            
        }.onAppear(perform: {
            self.ARData.AllObjets = [String: Int]()
            if self.ARData.repeatScene {
                self.setUpRepeat()
            } else {
                self.setUpNew()
            }
        })
    }
    
    func setUpNew() {
        if let keyValue = PlaygroundKeyValueStore.current["lettersString"], case .string(let text) = keyValue {
            print(text)
            self.ARData.lettersText = text
        }
    }
    
    func setUpRepeat() {
        if let keyValue = PlaygroundKeyValueStore.current["lettersString"], case .string(let text) = keyValue {
            print(text)
            self.ARData.lettersText = text
        }
        if let keyValue = PlaygroundKeyValueStore.current["build"], case .dictionary(let dict) = keyValue {
            print(dict)
            var dictonary = [String: Int]()
            for value in dict {
                if case let .integer(number) = value.value {
                    print(value.key)
                    print(number)
                    dictonary[value.key] = number
                }
            }
           
            print(dictonary)
            self.ARData.AllObjets = dictonary.mapValues { value in
                return value - 1
            }
        }
    }
    
    struct LeftObjects: View {
        var keys: [String]
        var dict: [String: Int]
        
        var body: some View {
            VStack() {
                ForEach(keys, id: \.self) { key in
                    VStack() {
                        if ("\(key)" != "Base") {
                            HStack() {
                                Text(key)
                                Spacer()
                                Text("\(self.dict[key] ?? 0)")
                            }
                        }
                    }
                    
                }
            }
            .padding()
            .background(Color.black.opacity(0.8))
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.blue, lineWidth: 2)
            )
            .font(.system(.body, design: .rounded))
            .frame(maxWidth: 130)
            .padding()
        }
    }
}
