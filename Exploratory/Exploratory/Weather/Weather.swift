//
//  Weather.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/19/23.
//

import Foundation


// Weather Structure
struct WeatherModel: Codable {
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let icon: String
}
