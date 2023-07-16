//
//  LandmarkedBody.swift
//  aeview
//
//  Created by Kevin Zheng on 2023-07-15.
//

import Foundation
import RealityKit
import ARKit

class LandmarkedBody: Entity {
    var bodyAnchor: ARBodyAnchor? = nil
    var injectionNodes: [(Entity, simd_float3)] = []
    
    required init(for bodyAnchor: ARBodyAnchor) {
        super.init()
        
        retrieveInjectionNodes()
        self.bodyAnchor = bodyAnchor
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    func update(with bodyAnchor: ARBodyAnchor) {
        let rootTransform = bodyAnchor.transform
        let rootPosition = simd_make_float3(rootTransform.columns.3)
        
        for injectionNode in injectionNodes {
            let nodeRelativePosition = injectionNode.1;
            let node = injectionNode.0;
            node.position = nodeRelativePosition + rootPosition
            // print("placed node at \(node.position)")
        }
    }
    
    func retrieveInjectionNodes() {
        let retrievedNodes = PersistentData.storedNodes
        for node in retrievedNodes {
            let newNode = ARInjectionNode.createNode(color: .green)
            self.injectionNodes.append((
                                        newNode,
                                        simd_make_float3(node[0], node[1], node[2])
                                       ))
            self.addChild(newNode)
        }
    }
}

