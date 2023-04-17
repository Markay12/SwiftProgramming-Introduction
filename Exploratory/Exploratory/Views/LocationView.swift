//
//  LocationView.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/16/23.
//

import SwiftUI
import MapKit

struct UserLocationView: View {
    var userLocation: UserLocation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Map(coordinateRegion: .constant(userLocation.coordinateRegion))
                .frame(height: 200)
            VStack(alignment: .leading, spacing: 6) {
                Text(userLocation.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(userLocation.address)
                    .font(.body)
                Text("Coordinates: \(userLocation.latitude), \(userLocation.longitude)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .navigationBarTitle(userLocation.name)
    }
}

struct UserLocationRow: View {
    var userLocation: UserLocation
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 6) {
                Text(userLocation.name)
                    .font(.headline)
                Text(userLocation.address)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 6) {
                Text("Lat: \(userLocation.latitude)")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("Long: \(userLocation.longitude)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
}


struct UserLocation: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    var coordinateRegion: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    }
}

