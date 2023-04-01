//
//  CoreData_IntroductionApp.swift
//  CoreData_Introduction
//
//  Created by Mark Ashinhust on 3/30/23.
//

import SwiftUI

@main
struct CoreData_IntroductionApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
