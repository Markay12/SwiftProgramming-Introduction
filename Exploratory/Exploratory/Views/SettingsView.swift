//
//  SettingsView.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/13/23.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    
    // MARK: Setup variables for settings
    @State private var myProfile: User?
    @AppStorage("log_status") var logStatus: Bool = false
    
    var body: some View {
                
        NavigationStack
        {
            ScrollView(.vertical, showsIndicators: false)
            {
                
            }
            // Make the user data able to be refreshed
            .refreshable {
                // MARK: Refresh the user Data
            }
            .navigationTitle("My Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing)
                {
                    Menu
                    {
                        
                        // MARK: Logout / Delete Account
                        Button("Logout", action: logout)
                        
                        Button("Delete Account", role: .destructive)
                        {
                            
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.init(degrees: 90))
                            .tint(.black)
                            .scaleEffect(0.8)
                    }
                }
            }
        }
    }
    
    // MARK: Logout Function
    func logout()
    {
        try? Auth.auth().signOut()
        
        print("User Logged Out")
        logStatus = false
        
        print(logStatus)

    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
