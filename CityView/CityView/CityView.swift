//
//  CityView.swift
//  CityView
//
//  Created by Mark Ashinhust on 3/1/23.
//

import SwiftUI
import Foundation

public class CityView: ObservableObject {
    @Published var data = [City(name: "Munich", description: "Munich, the capital of Bavaria, is Germany's third largest city. It is located in the south of the country, and its main attractions include the Frauenkirche, Marienplatz, Viktualienmarkt and Hofbräuhaus. The city is also known for its annual Oktoberfest celebration.", image_string: "Munich Germany")]
    
    @Published var sections = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    @Published var CityGroups = [
        CityGroup(groupName: "A", cities: []),
        CityGroup(groupName: "B", cities: []),
        CityGroup(groupName: "C", cities: []),
        CityGroup(groupName: "D", cities: [
            City(name: "Detroit", description: "Detroit is the largest city in the state of Michigan and is a major business and cultural center in the Midwest. The city is known for its auto industry, music scene, and sports teams.", image_string: "detroit")
        
        ]),
        CityGroup(groupName: "E", cities: []),
        CityGroup(groupName: "F", cities: []),
        CityGroup(groupName: "G", cities: []),
        CityGroup(groupName: "H", cities: []),
        CityGroup(groupName: "I", cities: []),
        CityGroup(groupName: "J", cities: []),
        CityGroup(groupName: "K", cities: []),
        CityGroup(groupName: "L", cities: [
            City(name: "London", description: "London is the capital of England, and the United Kingdom. It is a leading global city in the arts, commerce, education, entertainment, fashion, finance, healthcare, media, professional services, research and development, tourism and transport all contribute to its prominence. It is one of the world's most populous cities.", image_string: "london")
        ]),
        CityGroup(groupName: "M", cities: [
            City(name: "Munich", description: "Munich, the capital of Bavaria, is Germany's third largest city. It is located in the south of the country, and its main attractions include the Frauenkirche, Marienplatz, Viktualienmarkt and Hofbräuhaus. The city is also known for its annual Oktoberfest celebration.", image_string: "munich")
        ]),
        CityGroup(groupName: "N", cities: []),
        CityGroup(groupName: "O", cities: []),
        CityGroup(groupName: "P", cities: [
            City(name: "Phoenix", description: "The capital of Arizona, Phoenix is a desert metropolis with a population of 1.6 million people. It is known for its sunny weather, as well as its five professional sports teams: the Suns (NBA), the Cardinals (NFL), the Diamondbacks (MLB), the Coyotes (NHL), and FC Phoenix (USL). The city also has a large number of golf courses and resorts.", image_string: "phoenix")
            
        ]),
        CityGroup(groupName: "Q", cities: []),
        CityGroup(groupName: "R", cities: []),
        CityGroup(groupName: "S", cities: []),
        CityGroup(groupName: "T", cities: [
            City(name: "Tokyo", description: "Tokyo is the capital of Japan and one of its 47 prefectures. The Greater Tokyo Area is the most populous metropolitan area in the world. Tokyo is often referred to as a city, but is officially known and governed as a 'metropolitan prefecture', which differs from and combines elements of both a city and a prefecture, a characteristic unique to Tokyo. The population of the prefecture exceeds 13 million, while the population of the Greater Tokyo Area is over 37 million.", image_string: "tokyo")
        
        ]),
        CityGroup(groupName: "U", cities: []),
        CityGroup(groupName: "V", cities: []),
        CityGroup(groupName: "W", cities: []),
        CityGroup(groupName: "X", cities: []),
        CityGroup(groupName: "Y", cities: []),
        CityGroup(groupName: "Z", cities: [])
    ]
    
    var count: Int {
        data.count
    }
    
    func getCity(at index: Int) -> City {
        return data[index]
    }
    
    func add(city: City) {
        data.append(city)
    }
    
    func removeCity(at index: Int) {
        data.remove(at: index)
    }
    
    func findCity(city: String) -> Int{
        var loc:Int = 0
        print(city)
        for f in data {
            if f.name == city {
                break;
            }
            loc = loc + 1
            print(loc)
        }
        
        return loc
    }
}
