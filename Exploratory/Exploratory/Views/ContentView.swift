//
//  ContentView.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/15/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("log_status") var logStatus: Bool = false
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
