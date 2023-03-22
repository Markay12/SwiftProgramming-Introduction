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
        City(name: "Philadelphia", description: "The city of brotherly love", image: "philadelphia")
    ]
    
    // variable if showing button to add cities
    @State private var showingAddCity = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cities.sorted { $0.name < $1.name }, id: \.name) { city in
                    NavigationLink(destination: CityDetailView(city: city)) {
                        HStack {
                            Image(city.image)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(12)
                            Text(city.name)
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
                            Image(systemName: "plus")
                        }))
                        .sheet(isPresented: $showingAddCity, content: {
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
