//
//  BodySkeleton.swift
//  aeview
//
//  Created by Kevin Zheng on 2023-07-14.
//

import Foundation
import RealityKit
import ARKit

class BodySkeleton: Entity {
    var bodyAnchor: ARBodyAnchor? = nil
    var bodyCollisionPlane: Entity? = nil
    var joints: [String: Entity] = [:]
    var bones: [String: Entity] = [:]
    var injectionNodes: [(Entity, simd_float3)] = [] // The 3D position of a node relative to body anchor
    
    required init(for bodyAnchor: ARBodyAnchor) {
        super.init()
        
        self.bodyAnchor = bodyAnchor
        
        for jointName in ARSkeletonDefinition.defaultBody3D.jointNames {
            var jointRadius: Float = 0.05
            var jointColor: UIColor = .yellow

            switch jointName {
            case "neck_1_joint", "neck_2_joint", "neck_3_joint", "neck_4_joint", "head_joint",
                "left_shoulder_1_joint", "right_shoulder_1_joint":
                jointRadius *= 0.5
            case "jaw_joint", "chin_joint", "left_eye_joint", "left_eyeLowerLid_joint", "left_eyeUpperLid_joint",
                "left_eyeball_joint", "nose_joint", "right_eye_joint", "right_eyeLowerLid_joint",
                "right_eyeUpperLid_joint", "right_eyeball_joint":
                jointRadius *= 0.2
            case _ where jointName.hasPrefix("spine_"):
                jointRadius *= 0.75
            case "left_hand_joint", "right_hand_joint":
                jointRadius *= 1
            case _ where jointName.hasPrefix("left_hand") || jointName.hasPrefix("right_hand"):
                jointRadius = 0
            case _ where jointName.hasPrefix("left_toes") || jointName.hasPrefix("right_toes"):
                jointRadius = 0
            default:
                jointRadius = 0.05
                jointColor = .green
            }
            
            let jointEntity = createJoint(radius: jointRadius, color: jointColor)
            joints[jointName] = jointEntity
            self.addChild(jointEntity)
        }
        
        for bone in Bones.allCases {
            guard let skeletonBone = createSkeletonBone(bone: bone, bodyAnchor: bodyAnchor)
            else { continue }
            
            let boneEntity = createBoneEntity(for: skeletonBone)
            bones[bone.name] = boneEntity
            self.addChild(boneEntity)
        }
        
        self.addChild(CollisionPlaneEntity.getCollisionPlane())
        self.bodyCollisionPlane = CollisionPlaneEntity.getCollisionPlane()
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    func update(with bodyAnchor: ARBodyAnchor) {
        let rootTransform = bodyAnchor.transform
        let rootPosition = simd_make_float3(bodyAnchor.transform.columns.3)
        
        for jointName in ARSkeletonDefinition.defaultBody3D.jointNames {
            if let jointEntity = joints[jointName],
               let jointEntityTransform = bodyAnchor.skeleton.modelTransform(for: ARSkeleton.JointName(rawValue: jointName)) {
                let jointEntityOffsetFromRoot = simd_make_float3(jointEntityTransform.columns.3)
                jointEntity.position = jointEntityOffsetFromRoot + rootPosition
                jointEntity.orientation = Transform(matrix: jointEntityTransform).rotation
            }
        }
        
        for bone in Bones.allCases {
            let boneName = bone.name
            
            guard let entity = bones[boneName], let skeletonBone = createSkeletonBone(bone: bone, bodyAnchor: bodyAnchor)
            else { continue }
            
            entity.position = skeletonBone.centerPosition
            entity.look(at: skeletonBone.toJoint.position, from: skeletonBone.centerPosition, relativeTo: nil)
        }
        
        for injectionNode in injectionNodes {
            let nodeRelativePosition = injectionNode.1;
            let node = injectionNode.0;
            node.position = nodeRelativePosition + rootPosition
        }
        
        if let plane = self.bodyCollisionPlane {
            guard let hipJointTransform = bodyAnchor.skeleton.modelTransform(for: .root) else { return }
            let rotationMatrix = simd_float4x4(SCNMatrix4MakeRotation(.pi / 2, 1, 0, 0))
            let combinedTransform = rootTransform * hipJointTransform * rotationMatrix
            plane.transform.matrix = combinedTransform
        }
    }
    
    func addInjectionNode(at hitResult: simd_float3, to arView: ARView) {
        let node = ARInjectionNode.createNode(color: .yellow)
        // node.position = hitResult
        
        let anchorTransform = bodyAnchor?.transform
        let anchorPosition = SIMD3<Float>(anchorTransform!.columns.3.x, anchorTransform!.columns.3.y, anchorTransform!.columns.3.z)
        let nodeLocalPosition = hitResult - anchorPosition
        injectionNodes.append((node, nodeLocalPosition))
        persistInjectionNodes()
        
        self.addChild(node)
    }
    
    private func persistInjectionNodes() {
        var persistableNodes: [[Float]] = []
        
        for injectionNode in injectionNodes {
            let nodeRelPosition = injectionNode.1;
            persistableNodes.append([nodeRelPosition.x, nodeRelPosition.y, nodeRelPosition.z])
        }
        PersistentData.storedNodes = persistableNodes
    }
    
    private func createJoint(radius: Float, color: UIColor = .white) -> Entity {
        let mesh = MeshResource.generateSphere(radius: radius)
        var material = SimpleMaterial()
        material.color = .init(tint: .blue.withAlphaComponent(0.3))
        let entity = ModelEntity(mesh: mesh, materials: [material])
        
        return entity
    }
    
    private func createSkeletonBone(bone: Bones, bodyAnchor: ARBodyAnchor) -> SkeletonBone? {
        guard let fromJointEntityTransform = bodyAnchor.skeleton.modelTransform(for: ARSkeleton.JointName(rawValue: bone.jointFromName)),
              let toJointEntityTransform = bodyAnchor.skeleton.modelTransform(for: ARSkeleton.JointName(rawValue: bone.jointToName))
        else { return nil }
        
        let rootPosition = simd_make_float3(bodyAnchor.transform.columns.3)
        
        let jointFromEntityOffsetFromRoot = simd_make_float3(fromJointEntityTransform.columns.3)
        let jointFromEntityPosition = jointFromEntityOffsetFromRoot + rootPosition
        
        let jointToEntityOffsetFromRoot = simd_make_float3(toJointEntityTransform.columns.3)
        let jointToEntityPosition = jointToEntityOffsetFromRoot + rootPosition
        
        let fromJoint = SkeletonJoint(name: bone.jointFromName, position: jointFromEntityPosition)
        let toJoint = SkeletonJoint(name: bone.jointToName, position: jointToEntityPosition)
        
        return SkeletonBone(fromJoint: fromJoint, toJoint: toJoint)
    }
    
    private func createBoneEntity(for skeletonBone: SkeletonBone, diameter: Float = 0.04, color: UIColor = .white) -> Entity {
        let mesh = MeshResource.generateBox(size: [diameter, diameter, skeletonBone.length], cornerRadius: diameter / 2)
        var material = SimpleMaterial()
        material.color = .init(tint: .white.withAlphaComponent(0.35))
        let entity = ModelEntity(mesh: mesh, materials: [material])
        
        return entity
    }
}
