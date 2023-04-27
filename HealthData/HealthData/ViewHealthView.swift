//
//  ViewHealthView.swift
//  HealthData
//
//  Created by Mark Ashinhust on 4/25/23.
//

import SwiftUI

struct ViewHealthView: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var healthData: [HealthData] = []

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select Date Range")) {
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                }

                Section(header: Text("Health Data")) {
                    Button("Fetch Data", action: fetchData)
                    ForEach(healthData) { data in
                        VStack(alignment: .leading) {
                            Text("Date: \(formattedDate(date: data.date))")
                            Text("Blood Pressure: \(data.bloodPressure ?? "")")
                            Text("Weight: \(data.weight ?? "")")
                            Text("Sugar Level: \(data.sugarLevel ?? "")")
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("View Health Data")
        }
    }

    func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }

    func formattedDate(date: Date?) -> String {
        guard let date = date else { return "" }
        return dateFormatter().string(from: date)
    }

    func fetchData() {
        healthData = DataManager.shared.fetchHealthData(startDate: startDate, endDate: endDate)
    }
}
