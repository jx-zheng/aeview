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
    var body: some View {
        ZStack() {
            LandmarkedARViewContainer().ignoresSafeArea(.all)
            VStack {
                InjectionNoteView()
                Spacer()
                Button(action: { self.presentationMode.wrappedValue.dismiss() }) { // TODO: action
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

