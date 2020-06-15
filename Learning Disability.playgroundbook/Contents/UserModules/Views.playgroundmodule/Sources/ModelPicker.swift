import PlaygroundSupport
import SwiftUI
import RealityKit
import ARKit
import ARModule

public struct ModelPicker: View {
    @ObservedObject var ARData: ARViewData
    
    public init(ARData: ARViewData) {
        self.ARData = ARData
    }
    
    public var body: some View {
        VStack() {
            Picker("Shapes", selection: $ARData.selectedShapeIndex) {
                ForEach(0..<self.ARData.objectShapes.count) { index in
                    Text(self.ARData.objectShapes[index].rawValue).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(10)
            .background(Color.black.opacity(0.5))
        }
    }
    
}
