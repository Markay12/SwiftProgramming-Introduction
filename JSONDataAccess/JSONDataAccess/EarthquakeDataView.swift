//
//  EarthquakeDataView.swift
//  JSONDataAccess
//
//  Created by Mark Ashinhust on 4/4/23.
//

import SwiftUI

struct Earthquake: Codable {
    let datetime: String
    let magnitude: Double
}

struct EarthquakeDataView: View {
    @State private var earthquakes = [Earthquake]()
    let city: String
    
    var body: some View {
        VStack {
            Text("Earthquake Data for \(city)")
                .font(.title)
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
                loadData()
            }
        }
    }
    
    func loadData() {
        guard let url = URL(string: "http://api.geonames.org/earthquakesJSON?north=43.45&south=23.45&east=102.06&west=122.06&username=markay") else {
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


struct EarthquakeDataView_Previews: PreviewProvider {
    static var previews: some View
    {
        EarthquakeDataView(city: "Phoenix")
    }
}
