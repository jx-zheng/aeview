//
//  SkeletonBone.swift
//  aeview
//
//  Created by Kevin Zheng on 2023-07-14.
//

import Foundation
import RealityKit

struct SkeletonBone {
    var fromJoint: SkeletonJoint
    var toJoint: SkeletonJoint
    
    var centerPosition: SIMD3<Float> {
        [(fromJoint.position.x + toJoint.position.x) / 2, (fromJoint.position.y + toJoint.position.y) / 2, (fromJoint.position.z + toJoint.position.z) / 2]
    }
    
    var length: Float {
        simd_distance(fromJoint.position, toJoint.position)
    }
}

