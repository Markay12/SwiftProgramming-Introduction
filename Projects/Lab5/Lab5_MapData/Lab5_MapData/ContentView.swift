//
//  ContentView.swift
//  Lab5_MapData
//
//  Created by Mark Ashinhust on 3/21/23.
//

import SwiftUI

struct ContentView: View {
    
    // random cities pre-populated
    @State private var cities = [
        City(name: "New York", description: "The city that never sleeps", image: "new-york"),
        City(name: "Los Angeles", description: "The city of angels", image: "los-angeles"),
        City(name: "Chicago", description: "The windy city", image: "chicago"),
        City(name: "Houston", description: "Space City", image: "houston"),
        City(name: "Tempe", description: "Home to Arizona State University!", image: "asu-stadium")
    ]
    
    // variable if showing button to add cities
    @State private var showingAddCity = false
    
    // main view
    var body: some View {
        
        // Navigation View making the list items clickable
        NavigationView {
            
            // List to show the cities and their images
            List {
                ForEach(cities.sorted { $0.name < $1.name }, id: \.name) { city in
                    NavigationLink(destination: CityDetailView(city: city)) {
                        HStack {
                            //City image on the left
                            Image(city.image)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(12)
                            //Name of the city on the right
                            Text(city.name)
                                .underline()
                        }
                    }
                }
                .onDelete(perform: {thisIndex in
                    cities.remove(atOffsets: thisIndex)
                })
            }
            .listStyle(InsetGroupedListStyle())
                        .navigationTitle("Cities")
                        .navigationBarItems(trailing: Button(action: {
                            showingAddCity = true
                        }, label: {
                            // Image to add to the map
                            Image(systemName: "plus.app")
                                
                        }))
                        // Show sheet to add a city
                        .sheet(isPresented: $showingAddCity, content: {
                            // Using the defined add city view to append the new city 
                            AddCityView { name, description, image in
                                let newCity = City(name: name, description: description, image: image)
                                cities.append(newCity)
                                showingAddCity = false
                            }
                        })
                    }
                }
            }

class CityTableViewCell: UITableViewCell {
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
