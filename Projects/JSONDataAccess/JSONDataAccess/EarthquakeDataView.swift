//
//  EarthquakeDataView.swift
//  JSONDataAccess
//
//  Created by Mark Ashinhust on 4/4/23.
//

import SwiftUI
import MapKit

// Structure to hold the datetime and the magnitude for Earthquake information
struct Earthquake: Codable {
    let datetime: String
    let magnitude: Double
}

struct EarthquakeDataView: View {
    
    // Earthquake data variable
    @State private var earthquakes = [Earthquake]()
    
    // Input city string coming from the user
    let city: String
    
    // Latitude and longitude values
    @State private var latitude: CLLocationDegrees = 0
    @State private var longitude: CLLocationDegrees = 0
    
    // Main view
    var body: some View {
        VStack {
            
            // Update title to reflect the city and/or address provided
            Text("Earthquake Data for \(city)")
                .font(.headline)
                .padding()
            
            // List out the earthquake data, only 10 using the prefix
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
    
    // Function to get the location based off the city string that was given.
    // This should work for both addresses and just city names.
    func getLocation(for city: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else {
                // error if the location cannot be found
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            // get the latitude and longitude based on the given placemark
            self.latitude = placemark.location?.coordinate.latitude ?? 0
            self.longitude = placemark.location?.coordinate.longitude ?? 0
            self.loadData()
        }
    }
    
    // load data for the CLGeocoder to retreive city location and information.
    // This is what allows us to get the location for a city by name.
    func loadData() {
        CLGeocoder().geocodeAddressString(city) { placemarks, error in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                print("Could not determine location for city: \(city)")
                return
            }
            
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            // Using what was given in the class structure, we can +- 10 to get the values for N, E, S, W
            let north = latitude + 10
            let south = latitude - 10
            let east = longitude + 10
            let west = longitude - 10
            
            // JSON URL that uses the north, east, south and west data for its location access
            let urlString = "http://api.geonames.org/earthquakesJSON?north=\(north)&south=\(south)&east=\(east)&west=\(west)&username=markay"
            
            // Checking in case of an invalid given URL
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
            
            // URL Request
            let request = URLRequest(url: url)
            
            // invoke the URL Request to get the location and earthquake data
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
                // In case of a missing city or bad given data
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }.resume()
        }
    }
}

// Quick view for the Canvas
struct EarthquakeDataView_Previews: PreviewProvider {
    static var previews: some View
    {
        EarthquakeDataView(city: "Phoenix")
    }
}

