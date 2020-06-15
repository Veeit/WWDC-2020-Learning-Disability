import SwiftUI
import PencilKit

public struct CanvasRepresentation : UIViewRepresentable {
    
    public init() {}
    
    //public let canvasView = PKCanvasView()
    public let canvas = canvasView()
    
    public func makeUIView(context: Context) -> canvasView {
        
        
        //canvasView.backgroundColor = .black
        //canvasView.tool = PKInkingTool(.pen, color: .lightGray, width: 40)
        return canvas
    }
    
    public func updateUIView(_ uiView: canvasView, context: Context) {
    }
}
