//
//  CityModel.swift
//  CityView
//
//  Created by Mark Ashinhust on 3/1/23.
//

import SwiftUI
import Foundation

// create struct for the city
struct City: Identifiable
{
    var id = UUID()
    var name: String
    var image: String
    var desc: String
    
    init(name: String, description: String, image_string: String) {
            self.name = name
            self.desc = description
            self.image = image_string
    }
    
    
}


struct section: Identifiable
{
    
    let id = UUID()
    let name = String()
    
}

struct CityGroup: Identifiable
{
    var id = UUID()
    var groupName : String
    var cities : [City]
    
}


