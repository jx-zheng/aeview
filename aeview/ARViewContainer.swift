//
//  ARViewContainer.swift
//  aeview
//
//  Created by Kevin Zheng on 2023-07-14.
//

import SwiftUI
import ARKit
import RealityKit

private var bodySkeleton: BodySkeleton?
private let bodySkeletonAnchor = AnchorEntity()

struct ARViewContainer: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    typealias UIViewType = ARView
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        
        arView.setupForBodyTracking()
        arView.scene.addAnchor(bodySkeletonAnchor)
        
        // handle tap to add injection node on body
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap))
        arView.addGestureRecognizer(tapGesture)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // do nothing
    }
    
    class Coordinator: NSObject {
        var container: ARViewContainer
            
        init(_ container: ARViewContainer) {
            self.container = container
        }
            
        @objc func handleTap(_ gestureRecognize: UITapGestureRecognizer) {
            let arView = gestureRecognize.view as! ARView
            let location = gestureRecognize.location(in: arView)
            let results = arView.hitTest(location)
            for result in results {
                if result.entity == CollisionPlaneEntity.getCollisionPlane() {
                    if let skeleton = bodySkeleton {
                        skeleton.addInjectionNode(at: result.position, to: arView)
                    }
                    break
                }
            }
        }
    }
}

extension ARView: ARSessionDelegate {
    func setupForBodyTracking() {
        let configuration = ARBodyTrackingConfiguration()
        self.session.run(configuration)
        self.session.delegate = self
    }
    
    public func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            if let bodyAnchor = anchor as? ARBodyAnchor {
                if let skeleton = bodySkeleton {
                    skeleton.update(with: bodyAnchor)
                } else {
                    bodySkeleton = BodySkeleton(for: bodyAnchor)
                    bodySkeletonAnchor.addChild(bodySkeleton!)
                }
            }
        }
    }
}
