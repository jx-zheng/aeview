//
//  LandmarkedARView.swift
//  aeview
//
//  Created by Kevin Zheng on 2023-07-15.
//

import Foundation
import SwiftUI

struct LandmarkedARView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var injectionModalState = InjectionModalGlobalStates.shared
    
    var body: some View {
        ZStack() {
            LandmarkedARViewContainer().ignoresSafeArea(.all)
            if injectionModalState.shouldShowInjectionModal {
                InjectionNoteView()
            }
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "arrow.triangle.2.circlepath.camera.fill")
                        .resizable()
                        .frame(width: 80, height: 63)
                        .foregroundColor(Color.blue)
                        .padding(.trailing)
                }
                Spacer()
                Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                        Text("Finish Viewing").bold()
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

