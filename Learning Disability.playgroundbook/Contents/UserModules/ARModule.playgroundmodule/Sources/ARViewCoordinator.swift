import SwiftUI
import ARKit
import RealityKit

public class ARViewCoordinator: NSObject, ARSessionDelegate {
    var arViewWarpper: ARViewWrapper // Over of the cordinator
    @ObservedObject var ARData: ARViewData
    
    public init(arViewWrapper: ARViewWrapper, arData: ARViewData) {
        self.arViewWarpper = arViewWrapper
        self.ARData = arData
    }
}
