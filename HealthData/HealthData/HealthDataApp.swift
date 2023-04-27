//
//  HealthDataApp.swift
//  HealthData
//
//  Created by Mark Ashinhust on 4/25/23.
//

import SwiftUI

@main
struct HealthDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
