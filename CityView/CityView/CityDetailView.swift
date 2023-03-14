//
//  CityDetailView.swift
//  CityView
//
//  Created by Mark Ashinhust on 3/3/23.
//

import SwiftUI
import Foundation

struct CityDetailView: View {
    @Binding var selectedCity: City?
    
    var body: some View {
        VStack {
            
            Spacer()
            
            // Display the city name with custom formatting
            Text(selectedCity?.name ?? "")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            
            // Display the city description with custom formatting
            Text(selectedCity?.desc ?? "")
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Image(selectedCity?.image ?? "")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height: 300)
                                .padding(.top, 20)
                                .clipShape(Circle()) // add round border
                                .overlay(Circle().stroke(Color.black, lineWidth: 4)) // add white border
                                            
            Spacer()
        }
        .navigationBarTitle(Text(selectedCity?.name ?? ""), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            selectedCity = nil
        }) {
            Image(systemName: "xmark")
        })
    }
}

