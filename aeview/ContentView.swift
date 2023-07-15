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

struct ContentView: View {
    var body: some View {
        NavigationView {
            
            VStack {

                CardView(name: "Lantus Solostar", dosage: "10 units subcutaneously nightly", chemical_name: "Insulin Glargine", last_dose: Date() )
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)

                CardView(name: "TruRapi", dosage: "3-5 units subcutaneously with meals", chemical_name: "Insulin Aspart" )
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                
                
                Button(action: {
                }, label: {
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
                })
            }
        }
//        .navigationTitle("Welcome Back!") // TODO: Not working :(

//        ARViewContainer()
//            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
