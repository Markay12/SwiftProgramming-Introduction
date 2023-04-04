//
//  furitViewModel.swift
//  fruitTableSectionsSwiftUI
//
//  Created by Janaka Balasooriya on 2/19/23.
//

import Foundation

public class fruitViewModel:ObservableObject
{
    @Published var data = [Fruit(name:"Apple", image:"apple"),
                     Fruit(name:"Orange",image:"orange"),
                     Fruit(name:"Banana",image:"banana"),
                     Fruit(name:"Peach",image:"peach"),
                     Fruit(name:"Cantaloupe",image:"peach"),
                     Fruit(name:"Cherry", image:"peach"),
                     Fruit(name:"Clementine", image:"peach"),
                           Fruit(name:"Coconut",image:"peach"),
                     Fruit(name: "Cranberry",image:"peach"),
                     Fruit (name: "Fig", image:"peach")]
    
    @Published var sections = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    @Published var FruitGroups = [
        FruitGroup(groupName: "A", fruits: [
            Fruit(name:"Apple", image:"apple")
        ]),
        FruitGroup(groupName: "B", fruits: [
            Fruit(name:"Banana", image:"banana")
        ]),
        FruitGroup(groupName: "C", fruits: [
            Fruit(name:"Cantaloupe", image:"apple"),
            Fruit(name:"Cantaloupe",image:"peach"),
            Fruit(name:"Cherry", image:"peach"),
            Fruit(name:"Clementine", image:"peach"),
            Fruit(name:"Coconut",image:"peach"),
            Fruit(name:"Cranberry",image:"peach")
        ]),
        FruitGroup(groupName: "D", fruits: [
            Fruit(name:"Apple", image:"apple")
        ]),
        FruitGroup(groupName: "E", fruits: []),
        
        FruitGroup(groupName: "F", fruits: [
            Fruit (name: "Fig", image:"peach")]
        ),
        
        FruitGroup(groupName: "G", fruits: []
        ),
        
        FruitGroup(groupName: "H", fruits: []
        ),
        
        FruitGroup(groupName: "I", fruits: []
        ),
        
        FruitGroup(groupName: "J", fruits: []
        ),
        
        FruitGroup(groupName: "K", fruits: []
        ),
        FruitGroup(groupName: "L", fruits: []
        ),
        FruitGroup(groupName: "M", fruits: []
        ),
        FruitGroup(groupName: "N", fruits: []
        ),
        FruitGroup(groupName: "O", fruits: []
        ),
        FruitGroup(groupName: "P", fruits: [Fruit(name:"Peach",image:"peach")]
        ),
        FruitGroup(groupName: "Q", fruits: []
        ),
        FruitGroup(groupName: "R", fruits: []
        ),
        FruitGroup(groupName: "S", fruits: []
        ),
        FruitGroup(groupName: "T", fruits: []
        ),
        FruitGroup(groupName: "U", fruits: []
        ),
        FruitGroup(groupName: "V", fruits: []
        ),
        FruitGroup(groupName: "W", fruits: []
        ),
        FruitGroup(groupName: "X", fruits: []
        ),
        FruitGroup(groupName: "Y", fruits: []
        ),
        FruitGroup(groupName: "X", fruits: []
        )
        
      ]
    
    var count: Int {
        data.count
    }
    
    func getFruit(at index: Int) -> Fruit {
        return data[index]
    }
    
    func add(fruit: Fruit) {
        data.append(fruit)
    }
    
     func removeFruit(at index: Int) {
        data.remove(at: index)
    }
    
    func findFruit(fruit: String) -> Int{
        var loc:Int = 0
        print(fruit)
        for f in data
        {
            if f.name == fruit
            {
                break;
              
            }
            loc = loc + 1
            print(loc)
        }
        return loc
    }
    
    
    
    
}
