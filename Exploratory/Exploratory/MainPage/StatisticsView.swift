//
//  StatisticsView.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/13/23.
//

import SwiftUI

struct StatisticsView: View {
    @ObservedObject var viewModel = StatisticsViewModel()

    var body: some View {
        VStack {
            Text("Statistics")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            VStack {
                VStack {
                    Text("\(viewModel.citiesVisited)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Text("Cities Visited")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack {
                    Text("\(viewModel.countriesVisited)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Text("Countries Visited")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack {
                    Text(String(format: "%.2f", viewModel.distanceTraveled) + " km")
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
    }
}


// MARK: Structure for Statistics
struct Statistics: Codable {
    var citiesVisited: Int
    var countriesVisited: Int
    var distanceTraveled: Double
}

