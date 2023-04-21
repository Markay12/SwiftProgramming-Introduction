//
//  HistoryView.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/13/23.
//

import SwiftUI

struct HistoryView: View {
    let cities = [
        ["name": "New York", "description": "The city that never sleeps."],
        ["name": "Los Angeles", "description": "The City of Angels."],
        ["name": "Chicago", "description": "The Windy City."],
        ["name": "Houston", "description": "Space City."],
        ["name": "Phoenix", "description": "The Valley of the Sun."],
        ["name": "Philadelphia", "description": "The City of Brotherly Love."],
        ["name": "San Antonio", "description": "The Alamo City."],
        ["name": "San Diego", "description": "America's Finest City."],
        ["name": "Dallas", "description": "The Big D."],
        ["name": "San Francisco", "description": "The Golden Gate City."],
        ["name": "Austin", "description": "The Live Music Capital of the World."],
        ["name": "Seattle", "description": "The Emerald City."],
        ["name": "Denver", "description": "The Mile High City."],
        ["name": "Miami", "description": "The Magic City."],
        ["name": "Atlanta", "description": "The ATL."],
        ["name": "Boston", "description": "The City on a Hill."],
        ["name": "Nashville", "description": "Music City, USA."],
        ["name": "Portland", "description": "The City of Roses."],
        ["name": "New Orleans", "description": "The Big Easy."],
        ["name": "Las Vegas", "description": "Sin City."]
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(cities, id: \.self) { city in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(city["name"] ?? "")
                            .font(.title3)
                            .bold()

                        Text(city["description"] ?? "")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Location History")
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
