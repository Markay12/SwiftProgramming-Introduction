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

// MARK: Begin Sign Up View
struct SignUpView: View {
    
    // MARK: Declaration of Variables
    @State private var email: String =  ""
    @State private var password: String =  ""
    @State var username: String =  ""
    @State var userProfilePic: Data?
    
    
    @State var isLoading: Bool = false
    @State var isStarting: Bool = false
    
    // Image picker
    @State var showImagePicker: Bool = false
    @State var photo: PhotosPickerItem?
    
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    
    
    @State private var isLoginSheetShowing: Bool = false
    
    
    // User Defaults
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var usernameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    
    // MARK: Begin Main View
    var body: some View {
        NavigationView
        {
            ZStack
            {
                
                Color.black
                
                // MARK: Login Visuals
                Circle()
                        .foregroundStyle(.linearGradient(
                            colors: [
                                Color(hex: 0xC1121F),
                                Color(hex: 0xf77f00),
                                Color(hex: 0xfcbf49)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 450, height: 450)
                        .rotationEffect(.degrees(-20)) // Rotation to follow the bottom circle
                        .offset(y: -300) // Move to top of the screen
                        // Add spin animation
                        .rotationEffect(Angle(degrees: isStarting ? 360 : 0)) // Add spin animation
                        .animation(.linear(duration: 2.0)) // Duration for animation
                
                Circle()
                        .foregroundStyle(.linearGradient(
                            colors: [
                                Color(hex: 0xC1121F),
                                Color(hex: 0xf77f00),
                                Color(hex: 0xfcbf49)
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
                
                
                // MARK: Begin Log In Text
                VStack(spacing: 10)
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
                    
                    // MARK: Text Fields
                    //username text field
                    TextField("", text: $username)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: username.isEmpty) {
                            Text("Full Name")
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
                        .textInputAutocapitalization(.none)
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
                    
                    
                    
                    // MARK: Sign Up Buttons
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
                                            Color(hex: 0x000000),
                                            Color(hex: 0xC1121F),
                                            Color(hex: 0xf77f00),
                                            Color(hex: 0xfcbf49),
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
                    
                    // MARK: GOTO Login
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
            .onAppear {
                // Call the animation function when the view appears
                isStarting = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    isStarting = false
                }
            }
            .overlay(content: {
                LoadingView(show: $isLoading)
            })
            // MARK: Image Picker
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
    
    // MARK: Close Keyboard Function
    func closeKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // MARK: Register User Function
    func registerUser()
    {
        isLoading = true
        closeKeyboard()
        
        Task
        {
            do
            {
                // Create the Firebase account
                try await Auth.auth().createUser(withEmail: email, password: password)
                
                // Upload Profile image
                guard let userUID = Auth.auth().currentUser?.uid else {return}
                guard let imageData = userProfilePic else {return}
                
                // Scale image to 150x150 view
                let image = UIImage(data: imageData)
                let scaledImage = image?.resized(to: CGSize(width: 150, height: 150))
                let scaledImageData = scaledImage?.jpegData(compressionQuality: 1.0) ?? imageData
                           
                // MARK: Storage
                let storageRef = Storage.storage().reference().child("Profile_Images").child(userUID)
                
                let _ = try await storageRef.putDataAsync(scaledImageData)
                
                
                // Image URL
                let downloadURL = try await storageRef.downloadURL()
             
                
                // Create the user firestore object
                let user = User(username: username, userID: userUID, userEmail: email, userProfileURL: downloadURL, userBio: "New Exploratory User", citiesVisited: 1, countriesVisited: 1, distanceTraveled: 0.0)
                
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
    
    // MARK: Set Error
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

// MARK: View Extension
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

// MARK: UI Image
extension UIImage {
    func resized(to targetSize: CGSize) -> UIImage? {
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        let newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}


// MARK: Color Extension
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
