//
//  LoginView.swift
//  AeView
//
//  Created by Aryaman on 2023-07-16.
//

import SwiftUI

struct LoginView: View {
    @State private var usernameInput: String = ""
    @State private var password: String = ""
    
    
    var body: some View {
        NavigationView {
            
            VStack {
                ZStack {
                    Image("Logo")
                }
                .frame(width: 150, height: 125)
                .padding(.bottom, 50)
                
                TextField("Username", text: $usernameInput)
                    .font(.title3)
                    .bold()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                
                SecureField("Password", text: $password)
                    .font(.title3)
                    .bold()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.trailing, .leading])
                
                Text("Need help?")
                    .font(.caption)
                    .underline()
                    .italic()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 25)
                    .padding(.top, 3)
                
                NavigationLink(destination: ContentView()) {
                    Text("Sign In")

                        .font(.headline)
                        .frame(width: 120, height:40)
                        .foregroundColor(Color.white)
                        .background(Color(red: 0.41, green: 0.76, blue: 0.97))
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 25)
                
                
                Text("Don't have an account?")
                    .font(.caption)
                    .underline()
                    .italic()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 25)
                    .padding(.top, 30)
                
                NavigationLink(destination: ContentView()) {
                    Text("Sign Up")
                        .font(.headline)
                        .frame(width: 200, height:60)
                        .foregroundColor(Color.white)
                        .background(Color(red: 0.53, green: 0.52, blue: 0.52))
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 25)
                
                
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
