//
//  StatisticsViewModel.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/19/23.
//

import Foundation


class StatisticsViewModel: ObservableObject {
    @Published var citiesVisited: Int = 0
    @Published var countriesVisited: Int = 0
    @Published var distanceTraveled: Double = 0

    init() {
        fetchTravelHistory()
    }

    private func fetchTravelHistory() {
        // Retrieve the user's travel history from the database
        // Calculate the number of cities visited, countries visited, and distance traveled
        // Update the published variables accordingly
    }
}
