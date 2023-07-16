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
    
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // do nothing
    }
    
    class Coordinator: NSObject {
        var container: LandmarkedARViewContainer
            
        init(_ container: LandmarkedARViewContainer) {
            self.container = container
        }
    }
}
