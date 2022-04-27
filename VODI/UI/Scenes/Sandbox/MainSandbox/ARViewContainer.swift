//
//  ARViewContainer.swift
//  VODI
//
//  Created by Matthew Christopher Albert on 27/04/22.
//

import Foundation
import Combine
import ARKit
import RealityKit
import SwiftUI

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARBodyClothingView {
        let arView = ARBodyClothingView(frame: .zero)
        
        // Set debug options
        #if DEBUG
        arView.debugOptions = [.showFeaturePoints, .showAnchorOrigins, .showAnchorGeometry]
        #endif
        
        return arView
    }
    
    func updateUIView(_ uiView: ARBodyClothingView, context: Context) {
        DispatchQueue.main.async {
            uiView.becomeFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, ARSessionDelegate {
        weak var view: ARView?

        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let view = self.view else { return }
            debugPrint("Anchors added to the scene: ", anchors)
        }
    }
    
}

class ARBodyClothingView: ARView {
    
    var startNewLine = false
    var lastTouchPoint: UITouch?
    var subscription: Cancellable?
    var bodyEntity: HasModel? = nil
    
    static let sceneUnderstandingQuery = EntityQuery(where: .has(SceneUnderstandingComponent.self) && .has(ModelComponent.self))
    
    required init(frame: CGRect) {
        super.init(frame: frame)
        isMultipleTouchEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isMultipleTouchEnabled = true
    }
    
    override var canBecomeFirstResponder: Bool { true }
    
    func setup() {
        let configuration = ARBodyTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        session.run(configuration)
        
        subscription = scene.subscribe(to: SceneEvents.Update.self, onUpdate)
        
        let anchorEntity = AnchorEntity(.world(transform: .init(diagonal: [1, 1, 1, 1])))
        scene.anchors.append(anchorEntity)
    }
    
    /// This method finds the body model in a scene and returns it.
    func findBodyEntity(scene: RealityKit.Scene) -> HasModel? {

        let bodyEntity = scene.performQuery(Self.sceneUnderstandingQuery).first {
            $0.components[SceneUnderstandingComponent.self]?.entityType == .face
        }

        return bodyEntity as? HasModel
    }
    
    func onUpdate(_ event: Event) {
        guard let bodyEntity = self.bodyEntity else {
            self.bodyEntity = findBodyEntity(scene: scene)
            return
        }
        guard let lastTouchPoint = lastTouchPoint else {
            return
        }

        let lastTouchLocation = lastTouchPoint.location(in: self)
        
    }
}

extension ARBodyClothingView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPoint = touches.first
        startNewLine = true
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPoint = touches.first
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPoint = nil
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPoint = nil
    }
}
