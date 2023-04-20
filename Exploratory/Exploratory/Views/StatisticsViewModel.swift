//
//  StatisticsViewModel.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/19/23.
//

import Foundation


class StatisticsViewModel: ObservableObject {
    @Published var citiesVisited = 15
    @Published var countriesVisited = 2
    @Published var distanceTraveled = 121.668

    init() {
        fetchTravelHistory()
    }

    private func fetchTravelHistory() {
        // Retrieve the user's travel history from the database
        // Calculate the number of cities visited, countries visited, and distance traveled
        // Update the published variables accordingly
    }
}
