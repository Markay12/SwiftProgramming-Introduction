//
//  EnterHealthView.swift
//  HealthData
//
//  Created by Mark Ashinhust on 4/25/23.
//

import SwiftUI

// MARK: Enter the Health View
struct EnterHealthView: View {
    @State private var bloodPressure = ""
    @State private var weight = ""
    @State private var sugarLevel = ""
    @State private var date = Date()

    var body: some View {
        
        // MARK: Begin Navigation View
        NavigationView {
            Form {
                Section(header: Text("Enter Health Data")) {
                    TextField("Blood Pressure (Systolic/Diastolic)", text: $bloodPressure)
                    TextField("Weight (lbs)", text: $weight)
                    TextField("Morning Sugar Level", text: $sugarLevel)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
                
                Section {
                    Button("Save Data", action: saveData)
                }
            }
            .navigationTitle("Enter Health Data")
        }
    }
    
    // MARK: Save the Data
    func saveData() {
        DataManager.shared.saveHealthData(bloodPressure: bloodPressure, weight: weight, sugarLevel: sugarLevel, date: date)
        clearFields()
    }
    
    // MARK: Clear Field Function
    func clearFields() {
        bloodPressure = ""
        weight = ""
        sugarLevel = ""
        date = Date()
    }
}
