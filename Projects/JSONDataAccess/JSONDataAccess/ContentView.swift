//
//  ContentView.swift
//  JSONDataAccess
//
//  Created by Mark Ashinhust on 4/4/23.
//

import SwiftUI

struct ContentView: View {
    
    //City string access
    @State private var city: String = ""
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    
                    Text("Earthquake Information by City")
                        .bold()
                    
                    // Enter the city we want to search for
                    TextField("Enter your city name or address", text: $city)
                }
                
                Section {
                    // Button to search.
                    Button("Search") {
                        showSheet = true
                    }
                    //Show the sheet that includes the Earthquake information
                    .sheet(isPresented: $showSheet)
                    {
                        EarthquakeDataView(city: city)
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
