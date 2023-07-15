
//
//  AddDrugView.swift
//  aeview
//
//  Created by Aryaman on 2023-07-15.
//

import Foundation
import SwiftUI

struct AddDrugView: View {
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
                    
                    Button(action: {
                        // Submit form action
                        submitForm()
                    }) {
                        Text("Start Landmarking")
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .foregroundColor(.blue)
                            .cornerRadius(8)
                    }
                }
                .navigationBarTitle("Add Drug Form")
                .padding()
                .scrollContentBackground(.hidden)
            }
            .background(Color.gray.opacity(0.2))


    }
    
    func submitForm() {
        // Perform form submission or validation logic
        print("Form submitted!")
        print("Medication Name:", medicationName)
        print("Chemical Name:", chemicalName)
        print("Route of Administration:", selectedRoute)
        print("Notes:", notes)
    }
}

struct AddDrugView_Previews: PreviewProvider {
    static var previews: some View {
        AddDrugView()
    }
}
