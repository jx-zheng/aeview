//
//  InjectionNoteView.swift
//  aeview
//
//  Created by Aryaman on 2023-07-15.
//

import SwiftUI

struct InjectionNoteView: View {
    var body: some View {
        VStack {
            Text("Injection Site")
                .font(.headline)
                .padding(.top, 10)
            
            VStack {
                Text("Note: " + PersistentData.therapyNotes)
                    .padding(10)
                    .font(.caption)
            }
            .background(Color.white)
            .frame(maxWidth: 200)
            .cornerRadius(10)
            
            Text(PersistentData.medicationName)
                .font(.headline)
            
            Text(generateDosageString())
                .font(.caption2)
                .italic()
            
            
            HStack {
                NavigationLink(destination: ContentView()){
                    HStack {
                        Image(systemName: "chevron.backward.circle")

                        Text("Close")
                    }
                    .padding([.trailing, .leading], 18)
                    .padding([.top, .bottom], 15)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .font(.caption)
                    .cornerRadius(8)
                }
                .frame(width: 100)
                
                Button(action: {
                    // Action to perform when the button is tapped
                }) {
                    HStack {
                        Image(systemName: "syringe")
                        
                        Text("Inject")
                            .bold()
                    }
                    .padding([.trailing, .leading], 18)
                    .padding([.top, .bottom], 15)

                        .background(Color.white)
                        .foregroundColor(.blue)
                        .font(.caption)
                        .cornerRadius(8)
                }
                .frame(width: 100)
            }
            .padding(.bottom, 10)
        }
        .background(Color.gray.opacity(0.3))
        
    }
}

struct InjectionNoteView_Previews: PreviewProvider {
    static var previews: some View {
        InjectionNoteView()
    }
}
