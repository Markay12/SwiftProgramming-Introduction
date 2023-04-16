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
    
    @State private var email: String =  ""
    @State private var password: String =  ""
    @State var username: String =  ""
    @State var userProfilePic: Data?
    
    @State var isLoading: Bool = false
    
    // Image picker
    @State var showImagePicker: Bool = false
    @State var photo: PhotosPickerItem?
    
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    
    
    @State private var isLoginSheetShowing = false
    
    
    // User Defaults
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var usernameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    
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
                        
                        print("Sign up has been pressed")
                        
                        //if this button is clicked, register the user
                        registerUser()
                        
                        
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
                    .fullScreenCover(isPresented: $logStatus)
                    {
                        MainPage()
                    }
                    
                    
                    Button {
                        isLoginSheetShowing = true
                    } label: {
                        Text("Already have an Account?\nLogin Now")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .padding(.top)
                    .offset(y: 110)
                    .fullScreenCover(isPresented: $isLoginSheetShowing) {
                        LoginScreen()
                            .navigationBarBackButtonHidden(true)
                    }
                    
                }
                .frame(width: 350)
                
                
                
            }
            .ignoresSafeArea()
            .overlay(content: {
                LoadingView(show: $isLoading)
            })
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
            .alert(errorMessage, isPresented: $showError, actions: {})
            
        }
    }
    
    func registerUser()
    {
        isLoading = true
        Task
        {
            do
            {
                // Create the Firebase account
                try await Auth.auth().createUser(withEmail: email, password: password)
                
                // Upload Profile image
                guard let userUID = Auth.auth().currentUser?.uid else {return}
                guard let imageData = userProfilePic else {return}
                let storageRef = Storage.storage().reference().child("Profile_Images").child(userUID)
                
                let _ = try await storageRef.putDataAsync(imageData)
                
                
                // Image URL
                let downloadURL = try await storageRef.downloadURL()
             
                
                // Create the user firestore object
                let user = User(username: username, userID: userUID, userEmail: email, userProfileURL: downloadURL)
                
                // Save the user doc into firebase database
                let _ = try Firestore.firestore().collection("Users").document(userUID).setData(from: user, completion: {
                    error in
                    if error == nil {
                        //Saved Successfully
                        print("User has been created and saved successfully.")
                        usernameStored = username
                        self.userUID = userUID
                        profileURL = downloadURL
                        logStatus = true
                    }
                })
                
                
            }
            catch
            {
                await setError(error)
            }
        }
        
    }
    
    func setError(_ error: Error) async {
        
        // MARK: UI updated on the main thread
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
        
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
