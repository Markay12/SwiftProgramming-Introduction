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
    
    // MARK: Setup Variables
    
    
    // Email and password for login
    @State private var email = ""
    @State private var password = ""
    
    // sign up screen showing
    @State var isSignUpShowing: Bool = false
    
    // generic alert for login
    @State private var showAlert = false
    
    // Successful login state
    @State private var successfulLogin: Bool = false
    
    // Variable to show the main page
    @State private var showMainPage: Bool = false
    
    // Variable for loading
    @State var isLoading: Bool = false
    
    // MARK: Begin View
    
    var body: some View {
        NavigationView
        {
            ZStack
            {
                // Black background
                Color.black
                
                // MARK: Begin Formatting for Background
                
                // Gradient Rectangle for Formatting
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
                    .frame(width: 1000, height: 450) // Frame to encapsulate the text
                    .rotationEffect(.degrees(140)) // Rotation
                    .offset(y: -350) // Move to top of the screen
                
                VStack(spacing: 20)
                {
                    
                    // MARK: Text input for Users
                    // Sign In Text
                    Text("Sign In")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .offset(x: -100, y: -150)
                    
                    //email text field
                    TextField("", text: $email)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .textContentType(.emailAddress)
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
                    
                    
                    // MARK: Begin Login
                    // Button for user to login
                    Button
                    {
                        //Function to Login
                        login()
                        
                    } label: {
                        // login Text with background gradient same as the rounded rectangle
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
                    // Alert for invalid email and/or password
                    .alert(isPresented: $showAlert) {
                                    Alert(
                                        title: Text("Error"),
                                        message: Text("Invalid email or password"),
                                        dismissButton: .default(Text("OK"))
                                    )
                                }
                    .fullScreenCover(isPresented: $showMainPage)
                    {
                        // Show the main page 
                        MainPage()
                    }
                    
                    // MARK: Navigation to Sign Up
                    
                    Button {
                        isSignUpShowing = true
                    } label: {
                        Text("Don't have an Account?\nRegister Now")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .padding(.top)
                    .offset(y: 110)
                    .fullScreenCover(isPresented: $isSignUpShowing) {
                        SignUpView()
                            .navigationBarBackButtonHidden(true)
                    }
                    
                }
                .frame(width: 350)
                
            }
            .ignoresSafeArea()
        }
        // Show the loading wheel
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
    }
    
    func closeKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
    // MARK: Login Function
    func login() {
        
        isLoading = true
        closeKeyboard()
        
        // MARK: User Authentication
        // With error handling
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                // Handle login error
                print("Login error: \(error.localizedDescription)")
                showAlert = true
                isLoading = false
            } else {
                // Handle successful login
                print("User logged in successfully")
                successfulLogin = true
                showMainPage = true
            }
        }
    }
}

// MARK: Preview

struct loginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
