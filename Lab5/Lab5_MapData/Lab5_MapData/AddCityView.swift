//
//  AddCityView.swift
//  Lab5_MapData
//
//  Created by Mark Ashinhust on 3/21/23.
//

import SwiftUI

struct AddCityView: View {
    
    // Get the parameter information for the city
    @State private var name = ""
    @State private var description = ""
    @State private var image = ""
    
    var onSave: (String, String, String) -> Void
    
    // Setup body of the sheet.
    var body: some View {
        NavigationView {
            
            // Form for the user to add the information
            Form {
                Section(header: Text("City Info")) {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                    TextField("Image URL", text: $image)
                }
                Button(action: {
                    
                    // If user did not input image data, use asu-stadium.
                    if (image.isEmpty)
                    {
                        image = "asu-stadium"
                        
                    }
                    
                    onSave(name, description, image)
                }, label: {
                    Text("Save")
                })
            }
            .navigationTitle("Add City")
            
        }
    }
}
