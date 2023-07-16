//
//  LandmarkingARView.swift
//  aeview
//
//  Created by Kevin Zheng on 2023-07-15.
//

import Foundation
import SwiftUI
import ARKit

struct LandmarkingARView: View {
    @Binding var popToRootView : Bool
    
    var body: some View {
        ZStack() {
            ARViewContainer().ignoresSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "arrow.triangle.2.circlepath.camera.fill")
                        .resizable()
                        .frame(width: 80, height: 63)
                        .foregroundColor(Color.blue)
                        .padding(.trailing)
                        .onTapGesture {
                            let configuration = ARBodyTrackingConfiguration()
                            SkeletonResetSingleton.landmarkingArView?.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
                            SkeletonResetSingleton.shouldRebuildSkeleton = true
                            SkeletonResetSingleton.shouldRebuildCollisionPlane = true
                        }
                }
                Spacer()
                Button(action: { self.popToRootView = false; print(PersistentData.storedNodes) }) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                        Text("Finish Landmarking").bold()
                    }
                    .frame(width: 250, height:50)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding()
                }
            }
        }
    }
}

