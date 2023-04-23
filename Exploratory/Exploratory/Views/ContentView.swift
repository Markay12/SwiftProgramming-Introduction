//
//  ContentView.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/15/23.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Declaration of Variables
    @AppStorage("log_status") var logStatus: Bool = false
    
    // MARK: Begin View
    var body: some View {
        
        if logStatus
        {
            MainPage()
        }
        else
        {
            LoginScreen()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
