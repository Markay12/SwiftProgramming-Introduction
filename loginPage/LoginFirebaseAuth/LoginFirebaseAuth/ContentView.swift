//
//  ContentView.swift
//  LoginFirebaseAuth
//
//  Created by Mark Ashinhust on 3/14/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var email = ""
    @State var pass = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                VStack {
                    TextField("Email Address", text: $email)
                        .padding()
                        .textFieldStyle(SearchTextStyle())
                        .textContentType(.emailAddress)
                    SecureField("Password", text: $pass)
                        .padding()
                        .textFieldStyle(SearchTextStyle())
                        .textContentType(.password)
                    
                    
                    
                    //button to login with
                    Button(action: {
                        
                        
                    })
                    {
                        
                        Text("Sign In")
                        
                    }
                    .buttonStyle(MyButtonStyleBlue())
                    .padding()
                        
                }
                .padding()
                
                
                Spacer()
                
            }
            .navigationTitle("Sign In")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
