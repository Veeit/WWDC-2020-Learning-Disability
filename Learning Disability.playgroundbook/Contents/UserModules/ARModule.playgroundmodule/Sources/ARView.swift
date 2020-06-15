import RealityKit
import ARKit
import SwiftUI
import PlaygroundSupport

// ARView
public struct ARViewWrapper: UIViewRepresentable {
    @ObservedObject var ARData: ARViewData
    
    public init (ARData: ARViewData) {
        self.ARData = ARData
    }
    
    public typealias UIViewType = ARView
    
    public func makeCoordinator() -> ARViewCoordinator {
        return ARViewCoordinator(arViewWrapper: self, arData: self.ARData)
    }
    
    public func makeUIView(context: UIViewRepresentableContext<ARViewWrapper>) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        
        arView.addCoaching()
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
       
        if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
            config.frameSemantics.insert(.personSegmentationWithDepth)
        }
        arView.session.run(config, options: [])
        
        // add base
        
        let modelEntity = try! ModelEntity.loadModel(named: "Base-Cliff3") // loads USDZ
        modelEntity.name = "base"
        modelEntity.generateCollisionShapes(recursive: true)
        let anchorEntity = AnchorEntity(plane: .horizontal)
        anchorEntity.setScale(SIMD3<Float>(1, 1, 1), relativeTo: anchorEntity)
        anchorEntity.addChild(modelEntity)
        
        arView.scene.addAnchor(anchorEntity)
        
        arView.enablePlacement()
        
        // add coordinator to ARView
        arView.session.delegate = context.coordinator
        
        return arView
    }
    
    public func updateUIView(_ uiView: ARView, context: UIViewRepresentableContext<ARViewWrapper>) {
        
        if ARData.controlls == .Up {
            uiView.moveObject(up: true)
        } else if ARData.controlls == .Down {
            uiView.moveObject(up: false)
        } else if ARData.controlls == .Delete {
            uiView.deleteObject()
        }
    }
    
}

extension ARView {
    func enablePlacement() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        self.addGestureRecognizer(tapGestureRecognizer)
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        self.addGestureRecognizer(longPressGestureRecognizer)
        
    }
    
    func createModel(shape: Shape, text: String) -> ModelEntity {
        print(shape)
        if ("\(shape)" != "Text") {
            let entity = try! ModelEntity.loadModel(named: "\(shape)")
            entity.name = "\(shape)"
            entity.generateCollisionShapes(recursive: true)
            return entity
        } else {
            var newText = ""
            if text == "" {
                newText = "No text found"
            }  else {
                newText = text
            }
            let mesh = MeshResource.generateText(newText, extrusionDepth: 0.1, font: .systemFont(ofSize: 2), containerFrame: .zero, alignment: .left, lineBreakMode: .byTruncatingTail)
            let material = SimpleMaterial(color: .red, isMetallic: false)
            let entity = ModelEntity(mesh: mesh, materials: [material])
            entity.scale = SIMD3<Float>(0.03,0.03,0.3)
            entity.generateCollisionShapes(recursive: true)
            entity.name = "Text"
            return entity
        }
        
    }
    
    public func deleteObject() {
        guard let coordinator = self.session.delegate as? ARViewCoordinator else {
            print("Error obtaining coordinator")
            return
        }
        
        let location = coordinator.ARData.currentPressLocation
        
        let results = self.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let object = self.entity(at: location) {
            if object.name != "base" {
                object.removeFromParent()
            }
        }
    }
    
    public func moveObject(up: Bool) {
        guard let coordinator = self.session.delegate as? ARViewCoordinator else {
            print("Error obtaining coordinator")
            return
        }
        
        let location = coordinator.ARData.currentPressLocation
        
        let results = self.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let object = self.entity(at: location) {
            if object.name != "base" {
                var pos = Transform()
                if up {
                    pos.translation.y += 0.3
                } else {
                    pos.translation.y -= 0.3
                }
                object.move(to: pos, relativeTo: object)
            }
        }
    }
    
    @objc func handleLongPress(recognizer: UITapGestureRecognizer) {
        guard let coordinator = self.session.delegate as? ARViewCoordinator else {
            print("Error obtaining coordinator")
            return
        }
        
        let location = recognizer.location(in: self)
        
        //coordinator.ARData.currentPressLocation = location
        let results = self.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let object = self.entity(at: location) {
            if object.name != "base" {
                let value = coordinator.ARData.AllObjets["\(object.name)"] ?? 1
                object.removeFromParent()
                coordinator.ARData.AllObjets["\(object.name)"] = value - 1
            }
        }
    }
    
    // add new Object
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        
        guard let coordinator = self.session.delegate as? ARViewCoordinator else {
            print("Error obtaining coordinator")
            return
        }
        
        let location = recognizer.location(in: self)
        
        let results = self.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        //
        
        if let firstResult = results.first {
            if let base = self.entity(at: location) {
                if base.name == "base" {
                    let selectedShape = Shape.allCases[coordinator.ARData.selectedShapeIndex]
                    let modelEntity = createModel(shape: selectedShape, text: coordinator.ARData.lettersText)
                    self.installGestures(.all, for: modelEntity)
                    
                    let baseEntry = base as! ModelEntity
                    let anchorEntity = AnchorEntity(world: firstResult.worldTransform)
                    anchorEntity.addChild(modelEntity)
                    
                    anchorEntity.setPosition(SIMD3<Float>(0, 0.47, 0.7), relativeTo: anchorEntity)
                    //var pos = Transform()
                    //pos.translation.y = 0.47
                    
                    //modelEntity.move(to: pos, relativeTo: modelEntity)
                    //baseEntry.addChild(anchorEntity)
                    self.scene.addAnchor(anchorEntity)
                    let value = coordinator.ARData.AllObjets["\(selectedShape)"] ?? 1
                    if coordinator.ARData.repeatScene {
                        coordinator.ARData.AllObjets["\(selectedShape)"] = value - 1
                    } else {
                        coordinator.ARData.AllObjets["\(selectedShape)"] = value + 1
                    }
                    
                    PlaygroundKeyValueStore.current["build"] = .dictionary(coordinator.ARData.convertAllObjects() as! [String : PlaygroundValue])
                }
            }
        } else {
            print("failt, move more")
        }
    }
}

extension ARView: ARCoachingOverlayViewDelegate {
    func addCoaching() {
        
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.delegate = self
        coachingOverlay.session = self.session
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        coachingOverlay.goal = .anyPlane
        self.addSubview(coachingOverlay)
    }
    
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        //Ready to add entities next?
    }
}
