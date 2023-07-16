//
//  ARInjectionNode.swift
//  aeview
//
//  Created by Kevin Zheng on 2023-07-15.
//

import Foundation
import RealityKit

class ARInjectionNode {
    static func createNode() -> Entity {
        let mesh = MeshResource.generateSphere(radius: 0.02)
        let material = SimpleMaterial(color: .yellow, roughness: 0.8, isMetallic: false)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        return entity
    }
}
