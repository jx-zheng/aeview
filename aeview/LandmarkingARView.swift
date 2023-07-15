//
//  LandmarkingARView.swift
//  aeview
//
//  Created by Kevin Zheng on 2023-07-15.
//

import Foundation
import SwiftUI

struct LandmarkingARView: View {
    @Binding var popToRootView : Bool
    
    var body: some View {
        ZStack() {
            ARViewContainer().ignoresSafeArea(.all)
            VStack {
                Spacer()
                Button(action: { self.popToRootView = false }) {
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

