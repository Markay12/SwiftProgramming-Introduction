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

// MARK: Structure for Statistics
struct Statistics: Codable {
    var citiesVisited: Int
    var countriesVisited: Int
    var distanceTraveled: Double
}

// MARK: Begin View
struct StatisticsView: View {
    
    @StateObject var statsViewModel = StatisticsViewModel()
    
    // MARK: Control Body
    var body: some View {
        VStack {
            Text("Statistics")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            // MARK: Begin Images
            // Show the Visited Locations
            VStack {
                VStack {
                    Text("\(statsViewModel.citiesVisited)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Text("Cities Visited")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Image(systemName: "map.circle.fill")
                        .scaleEffect(2.5)
                        .offset(y: 25)
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
                    
                    Image(systemName: "globe.americas.fill")
                        .scaleEffect(2.5)
                        .offset(y: 25)
                    
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
                    
                    Image(systemName: "figure.hiking")
                        .scaleEffect(2.5)
                        .offset(y: 25)

                }
            }
            .padding()
            Spacer()
        }
        // MARK: Navigation Information
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(false)
        .onAppear {
            statsViewModel.fetchStats()
        }
    }
}


