//
//  LandmarkedARViewContainer.swift
//  aeview
//
//  Created by Kevin Zheng on 2023-07-15.
//

import SwiftUI
import ARKit
import RealityKit

private var landmarkedBody: LandmarkedBody?
private let bodyAnchor = AnchorEntity()

struct LandmarkedARViewContainer: UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    typealias UIViewType = ARView
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        
        arView.setupForBodyTracking()
        ARState.landmarkedBodyAnchor = bodyAnchor
        arView.scene.addAnchor(bodyAnchor)
        
        // handle tap on injection node on body
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap))
        arView.addGestureRecognizer(tapGesture)
    
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // do nothing
    }
    
    class Coordinator: NSObject {
        var container: LandmarkedARViewContainer
        let yellowMaterial = SimpleMaterial(color: .yellow, roughness: 0.8, isMetallic: false)
            
        init(_ container: LandmarkedARViewContainer) {
            self.container = container
        }
        
        @objc func handleTap(_ gestureRecognize: UITapGestureRecognizer) {
            let arView = gestureRecognize.view as! ARView
            let location = gestureRecognize.location(in: arView)
            let entityAtTap = arView.entity(at: location)
            
            if entityAtTap is ModelEntity {
                let modelEntity = entityAtTap as! ModelEntity
                modelEntity.model?.materials = [yellowMaterial]
                let injectionModalGlobalStates = InjectionModalGlobalStates.shared
                injectionModalGlobalStates.selectedNode = modelEntity
                injectionModalGlobalStates.shouldShowInjectionModal = true
            }
        }
    }
}
