//
//  CityDetailView.swift
//  CoreData_Introduction
//
//  Created by Mark Ashinhust on 3/30/23.
//

import SwiftUI
import Foundation

struct CityDetailView: View {
    
    let city: City
    @State private var cityImage: UIImage?
    
    var body: some View {
        VStack {
            Image(uiImage: cityImage ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            Text(city.name!)
                .font(.title)
                .bold()
                .padding()
            Text(city.desc!)
                .padding()
            Spacer()

        }
        .onAppear {
            if let imageData = Data(base64Encoded: city.image ?? ""), let uiImage = UIImage(data: imageData) {
                self.cityImage = uiImage
            }
        }
    }
}

