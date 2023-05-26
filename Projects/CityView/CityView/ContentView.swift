//
//  ContentView.swift
//  CityView
//
//  Created by Mark Ashinhust on 3/1/23.
//

import SwiftUI

struct ContentView: View {
    
    // Dictionary to hold the cities
    @ObservedObject var CityVM = CityView()
    
    @State var toInsertView = false
    @State var cityName = String()
    @State var cityType = String()
    
    @State var selectedCity: City? // Define selectedCity as an optional City variable
    @State var showingCityDetail = false
    
    @State var isInsertViewPresented = false
    @State var selectedCityGroup: CityGroup?
    
    @State public var newCityIndex: Int = 0
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(CityVM.CityGroups, id: \.id) { CityGroup in
                    Section(header: Text(CityGroup.groupName)) {
                        ForEach(CityGroup.cities) { city in
                            Button(action: {
                                // Open up the sheet detail view for the selected city
                                selectedCity = city
                                showingCityDetail = true
                            }) {
                                Text(city.name)
                            }
                        }.onDelete(perform: { indexSet in
                            let ind = groupNametoNum(gName: CityGroup.groupName)
                            if ind != -1 {
                                CityVM.CityGroups[ind].cities.remove(atOffsets: indexSet)
                            }
                        })
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("List Introduction")
            .navigationBarItems(
                trailing: Button(action: {
                    selectedCityGroup = nil
                    isInsertViewPresented = true
                    
                    
                    
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $isInsertViewPresented) {
                InsertView(isPresented: $isInsertViewPresented, cityVM: CityVM, newCityIndex: $newCityIndex)
            }
            .sheet(isPresented: $showingCityDetail) {
                CityDetailView(selectedCity: $selectedCity)
            }
        }
    }
}

struct InsertView: View {
    
    @Binding var isPresented: Bool
    @ObservedObject var cityVM: CityView
    
    @State var cityName = String()
    @State var group = String()
    
    @Binding var newCityIndex: Int
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("City Name")) {
                    TextField("Enter City Name", text: $cityName)
                    TextField("Enter Group Letter", text: $group)
                }
            }
            .navigationBarTitle("Insert City")
            .navigationBarItems(
                leading: Button("Cancel") {
                    isPresented = false
                },
                trailing: Button("Save")
                    {
                        let newCity = City(name: cityName, description: "Newly added city!", image_string: "munich")

                        let ind = groupNametoNum(gName: group) - 1
                    
                        
                        cityVM.CityGroups[ind].cities.append(newCity)
                        
                        cityVM.objectWillChange.send() // Notify the view that the object will change
                        newCityIndex = cityVM.CityGroups[ind].cities.count - 1 // Update the newCityIndex

                        
                        isPresented = false
                    }
                
                .disabled(cityName.isEmpty)
            )
        }
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
    
    return rVal
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
