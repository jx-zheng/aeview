
//
//  AddDrugView.swift
//  aeview
//
//  Created by Aryaman on 2023-07-15.
//

import Foundation
import SwiftUI

struct AddDrugView: View {
    @Binding var rootIsActive: Bool
    @Binding var refreshTherapyList: Bool
    
    @State private var medicationName = ""
    @State private var chemicalName = ""
    @State private var selectedRoute = "Subcutaneous"
    @State private var notes = ""
    
    let routes = ["Subcutaneous", "Intramuscular", "Transdermal"]
    
    var body: some View {
            VStack(alignment: .center)  {
                Form {
                    Section(header: Text("Medication Information")) {
                        TextField("Medication Name", text: $medicationName)
                        
                        TextField("Chemical Name", text: $chemicalName)
                    }
                    
                    Section(header: Text("Routes of Administration")) {
                        Picker(selection: $selectedRoute, label: Text("")) {
                            ForEach(routes, id: \.self) { route in
                                Text(route)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: .infinity)
                        .labelsHidden()
                        
                    }
                    
                    Section(header: Text("Notes")) {
                        TextEditor(text: $notes)
                            .frame(height: 100)
                    }
                    
                    NavigationLink(destination: LandmarkingARView(popToRootView: self.$rootIsActive)
                        .onAppear(perform: { self.persistTherapy() })
                        .navigationBarHidden(true)) {
                        Text("Start Landmarking")
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .foregroundColor(.blue)
                            .cornerRadius(8)
                        }.isDetailLink(false)
                }
                .navigationBarTitle("Add Drug Form")
                .padding()
                .scrollContentBackground(.hidden)
            }
            .background(Color.gray.opacity(0.2))


    }
    
    func persistTherapy() {
        // Store the therapy in UserDefaults
        PersistentData.medicationName = medicationName
        PersistentData.chemicalName = chemicalName
        PersistentData.routeOfAdministration = selectedRoute
        PersistentData.therapyNotes = notes
        self.refreshTherapyList.toggle()
    }
}

//struct AddDrugView_Previews: PreviewProvider {
//    static var previews: some View {
//        // AddDrugView()
//    }
//}
