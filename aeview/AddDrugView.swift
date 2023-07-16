
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
    @State private var dosage = ""
    @State private var selectedUnit = "mg"
    @State private var selectedFrequency = "Once a day"
    @State private var notes = ""
    
    let routes = ["Subcutaneous", "Intramuscular", "Transdermal"]
    let units = ["units", "mg", "ml" ]
    let frequencies = ["Once a week", "Once a day", "Twice a day", "Every 12 hours", "Every 4 hours", "Every hour"]

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
                    
                    Section(header: Text("Dosage")) {
                        VStack {
                            HStack {
                                TextField("Dosage", text: $dosage)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.decimalPad)
                                    .padding()
                                
                                Picker(selection: $selectedUnit, label: Text("")) {
                                    ForEach(units, id: \.self) { unit in
                                        Text(unit)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .labelsHidden()
                            }
                            Picker(selection: $selectedFrequency, label: Text("")) {
                                ForEach(frequencies, id: \.self) { frequency in
                                    Text(frequency)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .frame(maxWidth: .infinity)
                            .labelsHidden()
                            
                        }
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
        PersistentData.dosage = dosage
        PersistentData.unit = selectedUnit
        PersistentData.frequency = selectedFrequency
        PersistentData.therapyNotes = notes
        self.refreshTherapyList.toggle()
    }
}

//struct AddDrugView_Previews: PreviewProvider {
//    static var previews: some View {
//        // AddDrugView()
//    }
//}
