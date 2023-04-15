//
//  ContentView.swift
//  FirebaseLoginAuthentication
//
//  Created by Mark Ashinhust on 4/11/2023.
//

import SwiftUI
import Firebase
import PhotosUI
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage


struct SignUpView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State var username = ""
    @State var userProfilePic: Data?
    
    // Image picker
    @State var showImagePicker = false
    @State var photo: PhotosPickerItem?
    
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
                        .offset(x: -100, y: -110)
                    
                    ZStack
                    {
                        if let userProfilePic, let image = UIImage(data: userProfilePic){
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                        else
                        {
                            Image("GeneralProfileImage")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                        
                    }
                    .frame(width: 85, height: 85)
                    .clipShape(Circle())
                    .contentShape(Circle())
                    .padding(.top, 5)
                    .offset(y: -50)
                    .onTapGesture {
                        showImagePicker.toggle()
                    }
                    
                    //username text field
                    TextField("", text: $username)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: username.isEmpty) {
                            Text("Username")
                                .foregroundColor(.white)
                                .bold()
                        }
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
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
                        Text("Already have an Account?\nLogin Now")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .padding(.top)
                    .offset(y: 110)
                }
                .frame(width: 350)
                
                
                
            }
            .ignoresSafeArea()
            .photosPicker(isPresented: $showImagePicker, selection: $photo)
            .onChange(of: photo) { newValue in
                if let newValue
                {
                    Task{
                        do{
                            guard let imageData = try await newValue.loadTransferable(type: Data.self) else {return}
                            
                            await MainActor.run(body: {
                                userProfilePic = imageData
                            })
                            
                        } catch {}
                    }
                }
            }
            
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
