//
//  ContentView.swift
//  JSONDataAccess
//
//  Created by Mark Ashinhust on 4/4/23.
//

import SwiftUI

struct ContentView: View {
    @State private var city: String = ""
    @State private var showSheet = false
    
    var body: some View {
        Form {
            Section {
                TextField("Enter your city name or address", text: $city)
            }
            
            Section {
                Button("Search") {
                    showSheet = true
                }
                .sheet(isPresented: $showSheet)
                {
                    EarthquakeDataView(city: city)
                }
            }
        }
        .navigationBarTitle("Earthquake Information")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
