//
//  ContentView.swift
//  CoreData_Introduction
//
//  Created by Mark Ashinhust on 3/30/23.
//

import SwiftUI
import CoreData
import Foundation

struct ContentView: View {
    // Get the managed object context for Core Data
    @Environment(\.managedObjectContext) private var viewContext

    // Get all cities from Core Data, sorted by name
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \City.name, ascending: true)],
        animation: .default)
    private var cities: FetchedResults<City>

    // Show the Add City sheet
    @State var isAddCityViewPresented = false
    
    var body: some View {
        NavigationView {
            // Show a list of all cities
            List {
                ForEach(cities) { city in
                    // Go to CityDetailView when a city is tapped
                    NavigationLink(destination: CityDetailView(city: city)) {
                            Text(city.name!)
                        }
                }
                // Allow cities to be deleted by swiping left
                .onDelete(perform: deleteCities)
            }
            .navigationTitle("Cities")
            .toolbar {
                // Add button to show Add City sheet
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddCityViewPresented = true
                    }) {
                        Label("Add City", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddCityViewPresented) {
                // Show Add City sheet with callback to add new city
                AddCityView { name, description, image in
                    addItem(name: name, description: description, image: image)
                    isAddCityViewPresented = false
                }
            }
        }
    }

    // Add a new city to Core Data
    private func addItem(name: String, description: String, image: UIImage?) {
        withAnimation {
            let newCity = City(context: viewContext)
            newCity.name = name
            newCity.desc = description
            newCity.image = image?.jpegData(compressionQuality: 1)?.base64EncodedString()
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    // Delete cities from Core Data
    private func deleteCities(offsets: IndexSet) {
        withAnimation {
            offsets.map { cities[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


// Set the date formatter for displaying dates in previews
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        // Show ContentView with a preview context
        return ContentView()
            .environment(\.managedObjectContext, context)
    }
}
