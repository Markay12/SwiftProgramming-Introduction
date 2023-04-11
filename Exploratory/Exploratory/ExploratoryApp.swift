//
//  ExploratoryApp.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/4/23.
//

import SwiftUI
import Firebase

@main
struct ExploratoryApp: App {
    
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
