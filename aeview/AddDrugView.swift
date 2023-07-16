
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
                    Section(header:
                                Text("Medication Information")
                                    .bold()
                                    .foregroundColor(.black.opacity(0.7))
                                    .frame(maxWidth: .infinity, alignment: .center)

                    ) {
                        TextField("Medication Name", text: $medicationName)
                        
                        TextField("Chemical Name", text: $chemicalName)
                    }
                    
                    
                    Section(header:
                                Text("Routes of Administration")
                                    .bold()
                                    .foregroundColor(.black.opacity(0.7))
                                    .frame(maxWidth: .infinity, alignment: .center)
                    ) {
                        Picker(selection: $selectedRoute, label: Text("")) {
                            ForEach(routes, id: \.self) { route in
                                Text(route)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: .infinity)
                        .labelsHidden()
                    }
                    
                    Section(header: Text("Dosage")
                                        .bold()
                                        .foregroundColor(.black.opacity(0.7))
                                        .frame(maxWidth: .infinity, alignment: .center)) {
                        VStack {
                            HStack {
                                TextField("Dosage", text: $dosage)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.decimalPad)

                                
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
                    
                    Section(header: Text("Notes")
                                        .bold()
                                        .foregroundColor(.black.opacity(0.7))
                                        .frame(maxWidth: .infinity, alignment: .center))
                     {
                        TextEditor(text: $notes)
                            .frame(height: 100)
                    }
                    
                }
                .navigationBarTitle("Add Drug Form")
                .scrollContentBackground(.hidden)
                
                NavigationLink(destination: LandmarkingARView(popToRootView: self.$rootIsActive)
                    .onAppear(perform: { self.persistTherapy() })
                    .navigationBarHidden(true)) {
                        
                        HStack{
                            Image(systemName: "camera")
                            Text("Start Landmarking")
                        }
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(UIColor(red: 0.3, green: 0.69, blue: 0.31, alpha: 1)))
                            .cornerRadius(8)
                    }.isDetailLink(false)
                    .padding(20)
                    .padding(.bottom, 40)
                
                
                Spacer()
            }
            .background(Color.gray.opacity(0.2))


    }
    
    func persistTherapy() {
        // Set the AR state
        ARState.isLandmarking = true
        
        // Store the therapy in UserDefaults
        PersistentData.medicationName = medicationName
        PersistentData.chemicalName = chemicalName
        PersistentData.routeOfAdministration = selectedRoute
        PersistentData.dosage = dosage
        PersistentData.unit = selectedUnit
        PersistentData.frequency = selectedFrequency
        PersistentData.therapyNotes = notes
        //self.refreshTherapyList.toggle()
        
        PersistentData.didChangeDate = false
    }
}

struct AddDrugView_Previews: PreviewProvider {
    @State static var rootIsActive = false
    
    static var previews: some View {
        AddDrugView(rootIsActive: $rootIsActive)
    }
}
