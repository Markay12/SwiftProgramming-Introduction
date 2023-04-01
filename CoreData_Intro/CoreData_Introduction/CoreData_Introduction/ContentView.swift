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
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \City.name, ascending: true)],
        animation: .default)
    private var cities: FetchedResults<City>
    
    @State var isAddCityViewPresented = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cities) { city in
                    NavigationLink(destination: CityDetailView(city: city)) {
                            Text(city.name!)
                        }
                }
                .onDelete(perform: deleteCities)
            }
            .navigationTitle("Cities")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddCityViewPresented = true
                    }) {
                        Label("Add City", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddCityViewPresented) {
                AddCityView { name, description, image in
                    addItem(name: name, description: description, image: image)
                    isAddCityViewPresented = false
                }
            }
        }
    }

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
        return ContentView()
            .environment(\.managedObjectContext, context)
    }
}

