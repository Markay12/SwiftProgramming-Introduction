//
//  ContentView.swift
//  fruitTableSectionsSwiftUI
//
//  Created by Janaka Balasooriya on 2/19/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var fruitVM = fruitViewModel()
    @State var toInsertView = false
    @State var fruitName = String()
    @State var fruitType = String()
    
    var body: some View {
        NavigationView
        {
            List {
                ForEach(fruitVM.FruitGroups, id: \.id ) { FruitGroup in
                            Section(header: Text(FruitGroup.groupName)) {
                                ForEach(FruitGroup.fruits) { fruit in
                                    Text(fruit.name)
                                }.onDelete(perform: {IndexSet in
                                    print(IndexSet)
                                    let ind = groupNametoNum (gName: FruitGroup.groupName)
                                    if ind != -1 {
                                        fruitVM.FruitGroups[ind].fruits.remove(atOffsets: IndexSet)
                                    }

                                })
                            }
                        }
            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle("List Introduction")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                         
                            toInsertView = true
                            
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }.alert("Insert", isPresented: $toInsertView, actions: {
                   
                    TextField("Data:", text: $fruitName)
                    TextField("Category (A, B, ... Z):", text: $fruitType)

                    Button("Insert", action: {
                        let ind = groupNametoNum (gName: fruitType)
                        let fruit = Fruit(name: fruitName, image: "banana")
                        fruitVM.FruitGroups[ind].fruits.append(fruit)
                    })
                    Button("Cancel", role: .cancel, action: {
                        toInsertView = false
                    })
                }, message: {
                    Text("Please Enter Programming Language to Insert")
                })
        }
    }
    
    func groupNametoNum(gName:String)-> Int
    {
        var rVal:Int = -1
        switch gName
        {
        case "A":
            rVal = 0
        case "B":
            rVal = 1
        case "C":
            rVal = 2
        case "D":
            rVal = 3
        case "E":
            rVal = 4
        case "F":
            rVal = 5
        case "G":
            rVal = 6
        case "H":
            rVal = 7
        case "P":
            rVal = 16
        case "Q":
            rVal = 17
        case "I":
            rVal = 10
        case "J":
            rVal = 11
        case "K":
            rVal = 12
        case "L":
            rVal = 13
        case "M":
            rVal = 14
        case "N":
            rVal = 15
        case "O":
            rVal = 16
        case "R":
            rVal = 18
        case "S":
            rVal = 19
        case "T":
            rVal = 20
        case "U":
            rVal = 21
        case "V":
            rVal = 22
        case "W":
            rVal = 23
        case "X":
            rVal = 24
        case "Y":
            rVal = 25
        case "Z":
            rVal = 26
            
        default:
            rVal = -1
            
        }
        /*if gName == "C"
        {
            rVal = 2
        }*/
        
        return rVal
        
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
