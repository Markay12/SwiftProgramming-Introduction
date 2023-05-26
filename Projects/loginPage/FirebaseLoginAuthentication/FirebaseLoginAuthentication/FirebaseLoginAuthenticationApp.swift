//
//  FirebaseLoginAuthenticationApp.swift
//  FirebaseLoginAuthentication
//
//  Created by Mark Ashinhust on 3/16/23.
//

import SwiftUI
import Firebase

@main
struct FirebaseLoginAuthenticationApp: App {
    
    init()
    {
        
        FirebaseApp.configure()
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
