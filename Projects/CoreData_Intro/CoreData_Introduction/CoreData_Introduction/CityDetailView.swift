//
//  CityDetailView.swift
//  CoreData_Introduction
//
//  Created by Mark Ashinhust on 3/30/23.
//

// Import necessary libraries
import SwiftUI
import Foundation

// Define the CityDetailView as a SwiftUI View
struct CityDetailView: View {
    
    // City object passed from previous view
    let city: City
    
    // Local state variable to hold the UIImage object
    @State private var cityImage: UIImage?
    
    // Define the body of the view
    var body: some View {
        VStack {
            // Display the city image if it exists, otherwise display a default UIImage object
            Image(uiImage: cityImage ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            // Display the city name and description
            Text(city.name!)
                .font(.title)
                .bold()
                .padding()
            Text(city.desc!)
                .padding()
            
            // Spacer to push content to the top of the view
            Spacer()
        }
        .onAppear {
            // Try to get the image data from the city object, and if successful, convert it to a UIImage object and store it in the local state variable
            if let imageData = Data(base64Encoded: city.image ?? ""), let uiImage = UIImage(data: imageData) {
                self.cityImage = uiImage
            }
        }
    }
}
