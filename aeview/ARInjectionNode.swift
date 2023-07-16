//
//  ARInjectionNode.swift
//  aeview
//
//  Created by Kevin Zheng on 2023-07-15.
//

import Foundation
import RealityKit

class ARInjectionNode {
    static func createNode(color: SimpleMaterial.Color) -> Entity {
        let mesh = MeshResource.generateSphere(radius: 0.02)
        let material = SimpleMaterial(color: color, roughness: 0.8, isMetallic: false)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        
        let collisionShape = ShapeResource.generateSphere(radius: 0.02)
        entity.components[CollisionComponent] = CollisionComponent(shapes: [collisionShape])
        return entity
    }
}
