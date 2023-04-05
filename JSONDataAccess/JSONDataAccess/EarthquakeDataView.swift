//
//  EarthquakeDataView.swift
//  JSONDataAccess
//
//  Created by Mark Ashinhust on 4/4/23.
//

import SwiftUI
import MapKit

struct Earthquake: Codable {
    let datetime: String
    let magnitude: Double
}

struct EarthquakeDataView: View {
    @State private var earthquakes = [Earthquake]()
    let city: String
    
    @State private var latitude: CLLocationDegrees = 0
    @State private var longitude: CLLocationDegrees = 0
    
    var body: some View {
        VStack {
            Text("Earthquake Data for \(city)")
                .font(.subheadline)
                .padding()
            
            List(earthquakes.prefix(10), id: \.datetime) { earthquake in
                VStack(alignment: .leading) {
                    Text("Date: \(earthquake.datetime)")
                        .font(.headline)
                        .padding(.bottom, 1)
                    Text("Magnitude: \(earthquake.magnitude)")
                        .font(.subheadline)
                }
            }
            .onAppear {
                getLocation(for: city)
                
                
            }
        }
    }
    
    func getLocation(for city: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            self.latitude = placemark.location?.coordinate.latitude ?? 0
            self.longitude = placemark.location?.coordinate.longitude ?? 0
            self.loadData()
        }
    }
    
    func loadData() {
        CLGeocoder().geocodeAddressString(city) { placemarks, error in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                print("Could not determine location for city: \(city)")
                return
            }
            
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            let north = latitude + 10
            let south = latitude - 10
            let east = longitude + 10
            let west = longitude - 10
            
            let urlString = "http://api.geonames.org/earthquakesJSON?north=\(north)&south=\(south)&east=\(east)&west=\(west)&username=markay"
            
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
            
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode([String: [Earthquake]].self, from: data),
                       let earthquakes = decodedResponse["earthquakes"] {
                        DispatchQueue.main.async {
                            self.earthquakes = earthquakes
                        }
                        return
                    }
                }
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }.resume()
        }
    }
}


struct EarthquakeDataView_Previews: PreviewProvider {
    static var previews: some View
    {
        EarthquakeDataView(city: "Phoenix")
    }
}

