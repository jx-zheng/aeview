//
//  InjectionNoteView.swift
//  aeview
//
//  Created by Aryaman on 2023-07-15.
//

import SwiftUI
import RealityKit

struct InjectionNoteView: View {
    let redMaterial = SimpleMaterial(color: .red, roughness: 0.8, isMetallic: false)
    let greenMaterial = SimpleMaterial(color: .green, roughness: 0.8, isMetallic: false)
    
    var body: some View {
        VStack {
            Text("Injection Site")
                .font(.headline)
                .padding(.top, 10)
            
            VStack {
                Text("Notes: " + PersistentData.therapyNotes)
                    .padding(10)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
            }
            .background(Color.white)
            .frame(maxWidth: 200)
            .cornerRadius(10)
            
            Text(PersistentData.medicationName)
                .font(.headline)

            Text(generateDosageString())
                .font(.headline)
                .italic()

            
            HStack {
                Button(action: {
                    let globalModalState = InjectionModalGlobalStates.shared
                    globalModalState.selectedNode!.model?.materials = [greenMaterial]
                    globalModalState.shouldShowInjectionModal = false
                }) {
                    HStack {
                        Image(systemName: "chevron.backward.circle")
                        Text("Close")
                    }
                    .padding([.trailing, .leading], 35)
                    .padding([.top, .bottom], 15)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .font(.caption)
                    .cornerRadius(8)
                }.frame(width: 170)
                
                Button(action: {
                    let globalModalState = InjectionModalGlobalStates.shared
                    globalModalState.selectedNode!.model?.materials = [redMaterial]
                    globalModalState.shouldShowInjectionModal = false
                    PersistentData.lastAdministeredDate = Date()
                    PersistentData.didChangeDate = true
                }) {
                    HStack {
                        Image(systemName: "syringe")
                        
                        Text("Inject")
                            .bold()
                    }
                    .padding([.trailing, .leading], 35)
                    .padding([.top, .bottom], 15)

                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.caption)
                        .cornerRadius(8)
                }
                .frame(width: 170)
            }
            .padding(.bottom, 10)
        }
        .background(Color.white)
        .cornerRadius(8)
        
    }
}

struct InjectionNoteView_Previews: PreviewProvider {
    static var previews: some View {
        InjectionNoteView()
    }
}
