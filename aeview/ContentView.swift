//
//  ContentView.swift
//  aeview
//
//  Created by Kevin Zheng on 2023-07-14.
//

import SwiftUI


struct CardView: View {
    var name: String
    var dosage: String = "No dosage information"
    var chemical_name: String = ""
    var last_dose: Date?
    
    var last_dose_text: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
        
        if let lastDose = last_dose {
            return "Last Dose: " + dateFormatter.string(from: lastDose)
        } else {
            return "No last dose information found."
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(name)
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
                Text(chemical_name)
                    .font(.subheadline)
                    .italic()
                
            }
            Text(dosage)
                .font(.caption2)
                .foregroundColor(.gray)
            
            Text(last_dose_text)
                .font(.caption2)
                .foregroundColor(.orange)
                .bold()
        }
        
        .padding(16) // Add padding here
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 3, x: 0, y: 2)
        )
        .alignmentGuide(.cardHeight) { dimensions in
            dimensions.height
        }
        
    }
}

extension VerticalAlignment {
    private enum CardHeightAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.bottom]
        }
    }
    
    static let cardHeight = VerticalAlignment(CardHeightAlignment.self)
}

func generateDosageString() -> String {
    let dosage = PersistentData.dosage.lowercased()
    let unit = PersistentData.unit.lowercased()
    let routeOfAdministration = (PersistentData.routeOfAdministration.lowercased() + "ly")
    let frequency = PersistentData.frequency.lowercased()

    return "\(dosage) \(unit) \(routeOfAdministration) \(frequency)"
}

struct ContentView: View {
    @State var isActive: Bool = false
    @State private var refreshFlag = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome Back!")
                    .font(.title3)
                    .bold()
                VStack {
                    CardView(name: "Lantus Solostar", dosage: "10 units subcutaneously nightly", chemical_name: "Insulin Glargine", last_dose: Date() )
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    
                    CardView(name: "TruRapi", dosage: "3-5 units subcutaneously with meals", chemical_name: "Insulin Aspart" )
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    
                    let name = PersistentData.medicationName
                    if !name.isEmpty {
                        NavigationLink(destination: LandmarkedARView()
                            .navigationBarHidden(true)
                            .onAppear( perform: { ARState.isLandmarking = false } )) {
                            CardView(name: name, dosage: generateDosageString(), chemical_name: PersistentData.chemicalName)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                        }
                    }
                    
                    NavigationLink(destination: AddDrugView(rootIsActive: self.$isActive, refreshTherapyList: self.$refreshFlag),
                                   isActive: self.$isActive) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            
                            Text("Add New Therapy")
                                .bold()
                        }
                        .frame(width: 250, height:50)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding()
                    }.isDetailLink(false)
                }
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
