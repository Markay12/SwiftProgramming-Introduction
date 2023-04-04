//
//  fruitModel.swift
//  fruitTableSectionsSwiftUI
//
//  Created by Janaka Balasooriya on 2/19/23.
//

import Foundation

struct Fruit: Identifiable{
    var id = UUID()
    var name = String()
    //var description = String()
    var image = String()
    
}

struct section:Identifiable
{
    let id = UUID()
    let name: String
}

struct FruitGroup: Identifiable {
    var id = UUID()
    var groupName : String
    var fruits : [Fruit]
}
