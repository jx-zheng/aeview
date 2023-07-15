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
            let mesh = MeshResource.generatePlane(width: 0.4, depth: 0.7)
            let planeEntity = ModelEntity(mesh: mesh, materials: [UnlitMaterial(color: .clear)])
            let boxShape = ShapeResource.generateBox(size: [0.4, 0.001, 0.7]) // Thin box approximating a plane
            planeEntity.collision = CollisionComponent(shapes: [boxShape])
            CollisionPlane = planeEntity
            return planeEntity
        }
    }
}
