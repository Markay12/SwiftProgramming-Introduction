//
//  ContentView.swift
//  FirebaseLoginAuthentication
//
//  Created by Mark Ashinhust on 4/11/2023.
//

import SwiftUI
import Firebase
import Foundation


struct SignUpView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView
        {
            ZStack
            {
                
                Color.black
                
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundStyle(.linearGradient(
                        colors: [
                            Color(hex: 0xC1121F),
                            Color(hex: 0xf77f00),
                            Color(hex: 0xfcbf49)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 1000, height: 450)
                    .rotationEffect(.degrees(140))
                    .offset(y: -350)
                
                VStack(spacing: 20)
                {
                    
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .offset(x: -100, y: -150)
                    
                    //email text field
                    TextField("Email", text: $email)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: email.isEmpty) {
                            Text("Email")
                                .foregroundColor(.white)
                                .bold()
                        }
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
                    SecureField("Password", text: $password)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: password.isEmpty){
                            Text("Password")
                                .foregroundColor(.white)
                                .bold()
                        }
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
                    Button
                    {
                        
                        //if this button is clicked, register the user
                        
                        registerUser(email: email, password: password) { authResult, error in
                            if let error = error {
                                // Handle registration error
                                print("Registration error: \(error.localizedDescription)")
                            } else if let authResult = authResult {
                                // Handle successful registration
                                let user = authResult.user
                                print("User registered successfully: \(user.uid)")
                            }
                        }
                        
                        
                    } label: {
                        Text("Sign Up")
                            .bold()
                            .frame(width: 200, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.linearGradient(
                                        colors: [
                                            Color(hex: 0xC1121F),
                                            Color(hex: 0xf77f00),
                                            Color(hex: 0xfcbf49)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ))
                            )
                            .foregroundColor(.white)
                    }
                    .padding(.top)
                    .offset(y: 100)
                    
                    NavigationLink(destination: LoginScreen()
                        .navigationBarBackButtonHidden(true))
                    {
                        Text("Been here before?")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .padding(.top)
                    .offset(y: 110)
                }
                .frame(width: 350)
                
                
                
            }
            .ignoresSafeArea()
            
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            completion(authResult, error)
        }
    }
}



struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

// Extension to use hex colors
extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
