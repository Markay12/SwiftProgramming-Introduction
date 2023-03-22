//
//  AddCityView.swift
//  Lab5_MapData
//
//  Created by Mark Ashinhust on 3/21/23.
//

import SwiftUI

struct AddCityView: View {
    
    @State private var name = ""
    @State private var description = ""
    @State private var image = ""
    
    var onSave: (String, String, String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("City Info")) {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                    TextField("Image URL", text: $image)
                }
                Button(action: {
                    
                    if (image.isEmpty)
                    {
                        image = "new-york"
                        
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
