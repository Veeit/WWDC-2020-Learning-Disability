import SwiftUI
import SceneKit

public struct Letter3dRepresentation : UIViewRepresentable {
    var displayText = "b"
    public init(text: String = "b") {
        self.displayText = text
    }
    
    public let sceneView = SCNView()
    
    public func makeUIView(context: Context) -> SCNView {
        
        let scene = SCNScene()
        let text = SCNText(string: displayText, extrusionDepth: 5)
        text.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        text.firstMaterial?.diffuse.contents  = UIColor.red
        text.firstMaterial?.specular.contents = UIColor.white
        let textNode = SCNNode(geometry: text)
        textNode.position = SCNVector3(x: textNode.boundingBox.max.x / 2 * -1, y: 0, z: 0)
        scene.rootNode.addChildNode(textNode)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 10, z: 35)
        scene.rootNode.addChildNode(cameraNode)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 35)
        scene.rootNode.addChildNode(lightNode)
        // 6: Creating and adding ambien light to scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        sceneView.allowsCameraControl = true
        
        // Show FPS logs and timming
        //sceneView.showsStatistics = true
        
        // Set background color
        sceneView.backgroundColor = UIColor.systemBackground
        
        // Allow user translate image
        sceneView.cameraControlConfiguration.allowsTranslation = false
        
        // Set scene settings
        sceneView.scene = scene
        
        return sceneView
    }
    
    public func updateUIView(_ uiView: SCNView, context: Context) {
    }
}
