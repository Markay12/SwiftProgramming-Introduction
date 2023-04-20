//
//  StatisticsView.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/13/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

struct StatisticsView: View {
    @ObservedObject var statsViewModel = StatisticsViewModel()

    var body: some View {
        VStack {
            Text("Statistics")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            VStack {
                VStack {
                    Text("\(statsViewModel.citiesVisited)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Text("Cities Visited")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack {
                    Text("\(statsViewModel.countriesVisited)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Text("Countries Visited")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack {
                    Text(String(format: "%.2f", statsViewModel.distanceTraveled) + " km")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Text("Distance Traveled")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(false)
        .onReceive(statsViewModel.objectWillChange) { _ in
            // Update the view when the citiesVisited value changes
            // You can do the same for the other properties if needed
        }
    }
}



// MARK: Structure for Statistics
struct Statistics: Codable {
    var citiesVisited: Int
    var countriesVisited: Int
    var distanceTraveled: Double
}

