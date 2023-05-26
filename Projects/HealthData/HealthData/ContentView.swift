//
//  ContentView.swift
//  HealthData
//
//  Created by Mark Ashinhust on 4/25/23.
//

import SwiftUI

// MARK: Begin Content View

struct ContentView: View {
    var body: some View {
        
        // MARK: Main Tab view
        TabView {
            
            // Enter Health
            EnterHealthView()
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("Enter Data")
                }

            // View Health
            ViewHealthView()
                .tabItem {
                    Image(systemName: "eye")
                    Text("View Data")
                }
        }
    }
}

// MARK: Content Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
