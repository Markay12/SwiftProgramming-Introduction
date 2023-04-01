//
//  AddCityView.swift
//
//
//  Created by Mark Ashinhust on 3/21/23.
//

import SwiftUI

struct AddCityView: View {
    
    // Get the parameter information for the city
    @State private var name = ""
    @State private var description = ""
    @State private var image = UIImage(named: "placeholder")!
    @State private var showImagePicker = false
    
    var onSave: (String, String, UIImage) -> Void
    
    // Setup body of the sheet.
    var body: some View {
        NavigationView {
            
            // Form for the user to add the information
            Form {
                Section(header: Text("City Info")) {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                    Button(action: {
                        self.showImagePicker = true
                    }, label: {
                        Text("Select Image")
                    })
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()

                    
                }
                Button(action: {
                    
                    onSave(name, description, image)
                }, label: {
                    Text("Save")
                })
            }
            .navigationTitle("Add City")
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
            }
            
        }
    }
}
