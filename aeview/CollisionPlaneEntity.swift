//
//  CollisionPlaneEntity.swift
//  aeview
//
//  Created by Kevin Zheng on 2023-07-15.
//

import RealityKit

class CollisionPlaneEntity {
    static private var CollisionPlane: Entity? = nil
    private init () {}
    
    static func getCollisionPlane() -> Entity {
        if let plane = CollisionPlane {
            return plane
        } else {
            let mesh = MeshResource.generatePlane(width: 0.5, depth: 1)
            //let material = SimpleMaterial(color: .blue, isMetallic: false)
            //let planeEntity = ModelEntity(mesh: mesh, materials: [material])
            let transparentMaterial = SimpleMaterial(color: .clear, isMetallic: false)
            let planeEntity = ModelEntity(mesh: mesh, materials: [transparentMaterial])
            let boxShape = ShapeResource.generateBox(size: [0.5, 0.001, 1]) // Thin box approximating a plane
            planeEntity.collision = CollisionComponent(shapes: [boxShape])
            CollisionPlane = planeEntity
            return planeEntity
        }
    }
}
