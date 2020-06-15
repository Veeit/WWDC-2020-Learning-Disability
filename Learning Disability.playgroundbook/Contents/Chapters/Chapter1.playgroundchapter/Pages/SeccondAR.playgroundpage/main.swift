
import PlaygroundSupport
import SwiftUI
import RealityKit
import ARKit

// SwiftUI
struct ContentView: View {
    @ObservedObject var ARData = ARViewData()
    
    var body: some View {
        ARView(ARData: ARData)
        .onAppear(perform: {
            self.ARData.repeatScene = true
        })
    }
}

// Playground
PlaygroundPage.current.setLiveView(ContentView())
PlaygroundPage.current.needsIndefiniteExecution = true // run for ever !!!

