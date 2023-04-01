//
//  AddCityView.swift
//
//
//  Created by Mark Ashinhust on 3/21/23.
//

import SwiftUI

struct AddCityView: View {
    
    // Get the parameter information for the city
    @State private var name = "" // city name
    @State private var description = "" // city description
    @State private var image = UIImage(named: "placeholder")! // city image
    @State private var showImagePicker = false // flag to show/hide image picker
    
    var onSave: (String, String, UIImage) -> Void // closure to save city info
    
    // Setup body of the sheet.
    var body: some View {
        NavigationView {
            
            // Form for the user to add the information
            Form {
                Section(header: Text("City Info")) {
                    TextField("Name", text: $name) // text field to enter city name
                    TextField("Description", text: $description) // text field to enter city description
                    Button(action: {
                        self.showImagePicker = true // show image picker when button is tapped
                    }, label: {
                        Text("Select Image") // button to select image
                    })
                    
                    Image(uiImage: image) // display selected image
                        .resizable()
                        .scaledToFit()

                    
                }
                Button(action: {
                    
                    onSave(name, description, image) // call onSave closure to save city info
                }, label: {
                    Text("Save") // button to save city info
                })
            }
            .navigationTitle("Add City") // set title of navigation bar
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $image) // show image picker as a sheet
            }
            
        }
    }
}
