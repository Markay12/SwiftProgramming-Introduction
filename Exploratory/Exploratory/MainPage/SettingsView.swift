//
//  SettingsView.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/13/23.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseStorage

struct SettingsView: View {
    
    // MARK: Setup variables for settings
    @State private var myProfile: User?
    
    // App storage data
    @AppStorage("log_status") var logStatus: Bool = false
    
    // Loading wheel
    @State private var isLoading: Bool = false
    
    @State var errorMessage: String = ""
    @State var showError: Bool = false
    
    var body: some View {
                
        NavigationStack
        {
            VStack
            {
                if let myProfile
                {
                    ProfileContent(user: myProfile)
                        .refreshable {
                            // MARK: Refresh the User Data
                            self.myProfile = nil
                            await fetchUserData()
                        }
                }
                else
                {
                    MainPage()
                }
            }
            .navigationTitle("My Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing)
                {
                    Menu
                    {
                        
                        // MARK: Logout / Delete Account
                        Button("Logout", action: logout)
                        
                        Button("Delete Account", role: .destructive, action: deleteAccount)
                    
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.init(degrees: 90))
                            .tint(.black)
                            .scaleEffect(0.8)
                    }
                }
            }
        }
        .overlay{
            LoadingView(show: $isLoading)
        }
        .alert(errorMessage, isPresented: $showError)
        {
            
        }
        .task {
            
            // Detched user data on the first time only
            if myProfile != nil {return}
            
            // Initial Fetch user data
            await fetchUserData()
        }
    }
    
    // MARK: Fetch the Users data
    func fetchUserData() async
    {
        
        guard let userUID = Auth.auth().currentUser?.uid else {return}
        guard let user = try? await Firestore.firestore().collection("Users").document(userUID).getDocument(as: User.self) else {return}
        await MainActor.run(body: {
            myProfile = user
        })
        
    }
    
    // MARK: Logout Function
    func logout()
    {
        try? Auth.auth().signOut()
        
        print("User Logged Out")
        logStatus = false
        
        print(logStatus)

    }
    
    // MARK: Delete Account
    
    func deleteAccount()
    {
        isLoading = true
        Task
        {
            do {
                guard let userUID = Auth.auth().currentUser?.uid else{return}
                
                // Delete profile image from storage
                let reference = Storage.storage().reference().child("Profile_Images").child(userUID)
                try await reference.delete()
                
                // Delete Firestore user doc
                try await Firestore.firestore().collection("Users").document(userUID).delete()
                
                // Delete auth account and set logStatus to false
                try await Auth.auth().currentUser?.delete()
                logStatus = false
                
            }
            catch {
                await setError(error)
                isLoading = false
            }
        }
        
    }
    
    // MARK: Error message
    func setError(_ error: Error) async {
        // UI Must be run on the main thread
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
