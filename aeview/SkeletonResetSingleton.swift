//
//  SkeletonResetSingleton.swift
//  AeView
//
//  Created by Kevin Zheng on 2023-07-16.
//

import RealityKit

// This class holds the ARView from the landmarking AR scene in a way so that I can access it anywhere in the project
// It also holds a toggle so that I know when the signal to rebuild the skeleton has been sent
class SkeletonResetSingleton {
    static var landmarkingArView: ARView? = nil
    static var shouldRebuildSkeleton: Bool = false
    static var shouldRebuildCollisionPlane: Bool = false
}
