import SwiftUI
import ARKit
import RealityKit
import PlaygroundSupport

public enum Shape: String, CaseIterable {
    case Tree, Text, Person, House, Table
}

public enum Controlls: CaseIterable {
    case Up, Down, Delete, None
}

public class ARViewData: ObservableObject {
    @Published public var currentPressLocation = CGPoint(x: 0, y: 0)
    @Published public var selectedShapeIndex = 0
    @Published public var objectShapes = Shape.allCases
    @Published public var controlls: Controlls = Controlls.None
    @Published public var lettersText = ""
    @Published public var AllObjets = [String: Int]()
    @Published public var repeatScene = false
    
    public init () {}
    
    public func convertAllObjects() -> Any {
        var dict = ["Base": PlaygroundValue.integer(1)]
        for entry in AllObjets {
            if entry.key != "Base" {
                dict[entry.key] = PlaygroundValue.integer(entry.value)
            }
        }
        return dict
    }
}


