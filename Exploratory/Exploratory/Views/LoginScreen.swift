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
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var usernameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    
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
    @State var isStarting: Bool = false
    
    // MARK: Begin View
    var body: some View {
        NavigationView
        {
            ZStack
            {
                // Black background
                Color.black
                
                // MARK: Formatting for Background
                // Gradient Rectangle for Formatting
                Circle()
                        .foregroundStyle(.linearGradient(
                            colors: [
                                Color(hex: 0x02198B),
                                Color(hex: 0x253DA1),
                                Color(hex: 0xB0DBF1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 450, height: 450)
                        .rotationEffect(.degrees(-20)) // Rotation to follow the bottom circle
                        .offset(y: -350) // Move to top of the screen
                        // Add spin animation
                        .rotationEffect(Angle(degrees: isStarting ? 360 : 0)) // Add spin animation
                        .animation(.linear(duration: 2.0)) // Duration for animation
                
                Circle()
                        .foregroundStyle(.linearGradient(
                            colors: [
                                Color(hex: 0x02198B),
                                Color(hex: 0x253DA1),
                                Color(hex: 0xB0DBF1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 450, height: 450)
                        .rotationEffect(.degrees(-20)) // Rotation to follow the bottom circle
                        .offset(y: 325) // Move to top of the screen
                        // Add spin animation
                        .rotationEffect(Angle(degrees: isStarting ? 360 : 0)) // Add spin animation
                        .animation(.linear(duration: 2.0)) // Duration for animation
                
                
                VStack(spacing: 20)
                {
                    
                    // MARK: Text input for Users
                    
                    Text("Exploratory")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .offset(x: -60, y: -150)
                    
                    // Sign In Text
                    Text("Sign In")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .offset(x: -126, y: -170)
                    
                    // MARK: Email Field
                    //email text field
                    TextField("", text: $email)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.none)
                        .placeholder(when: email.isEmpty) {
                            Text("Email")
                                .foregroundColor(.white)
                                .bold()
                        }
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
                    // MARK: Password Field
                    
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
                        
                        // MARK: Sign in Button
                        
                        // login Text with background gradient same as the rounded rectangle
                        Text("Sign in")
                            .bold()
                            .frame(width: 200, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.linearGradient(
                                        colors: [
                                            Color(hex: 0x000000),
                                            Color(hex: 0x02198B),
                                            Color(hex: 0x253DA1),
                                            Color(hex: 0x000000)
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
            // Animation of the main circles
            .onAppear {
                // Call the animation function when the view appears
                isStarting = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    isStarting = false
                }
            }
            
            
        }
        // Show the loading wheel
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        
        
    }
    
    
    // MARK: Close Keyboard Function
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
                logStatus = false
            } else {
                // Handle successful login
                print("User logged in successfully")
                
                // Set boolean variables
                logStatus = true
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
