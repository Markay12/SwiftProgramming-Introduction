//
//  loginScreen.swift
//  FirebaseLoginAuthentication
//
//  Created by Mark Ashinhust on 3/17/23.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseAuth


struct LoginScreen: View {
    
    @State private var email = ""
    @State private var password = ""
    
    // generic alert for login
    @State private var showAlert = false
    
    @State private var successfulLogin = false
    
    // Variable to show the main page
    @State private var showMainPage = false
    
    var body: some View {
        NavigationView
        {
            ZStack
            {
                
                Color.black
                
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundStyle(.linearGradient(
                        colors: [
                            Color(hex: 0xfcbf49),
                            Color(hex: 0xd62828),
                            Color(hex: 0xeae2b7)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 1000, height: 450)
                    .rotationEffect(.degrees(140))
                    .offset(y: -350)
                
                VStack(spacing: 20)
                {
                    
                    Text("Sign In")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .offset(x: -100, y: -150)
                    
                    //email text field
                    TextField("", text: $email)
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
                    
                    SecureField("", text: $password)
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
                        
                        //Function to Login
                        login()
                        
                    } label: {
                        Text("Log in")
                            .bold()
                            .frame(width: 200, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.linearGradient(
                                        colors: [
                                            Color(hex: 0xc1121f),
                                            Color(hex: 0xd62828)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ))
                            )
                            .foregroundColor(.white)
                    }
                    .padding(.top)
                    .offset(y: 100)
                    .alert(isPresented: $showAlert) {
                                    Alert(
                                        title: Text("Error"),
                                        message: Text("Invalid email or password"),
                                        dismissButton: .default(Text("OK"))
                                    )
                                }
                    
                    if showMainPage {
                        NavigationLink(
                            destination: MainPage()
                                .navigationBarBackButtonHidden(true)
                                ,
                            isActive: $showMainPage) {
                                EmptyView()
                                
                        }
                    }
                    
                    
                    
                    NavigationLink(destination: SignUpView()
                        .navigationBarBackButtonHidden(true))
                    {
                        Text("Don't have an Account?\nRegister Now")
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
    
    func login() {
            Auth.auth().signIn(withEmail: email, password: password) { _, error in
                if let error = error {
                    // Handle login error
                    print("Login error: \(error.localizedDescription)")
                    showAlert = true
                } else {
                    // Handle successful login
                    print("User logged in successfully")
                    successfulLogin = true
                    showMainPage = true
                }
            }
        }
    
}



struct loginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
