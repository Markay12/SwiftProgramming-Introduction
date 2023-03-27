//
//  HealthSummary.swift
//  PatientPortal
//
//  Created by Mark Ashinhust on 3/22/23.
//

import SwiftUI


struct HealthSummary: View {
    let healthData: [HealthData]

    var body: some View {
        List {
            // Section header for Systolic BP
            Section(header: Text("Blood Pressure Systolic")) {
                // Get all systolic bp values
                ForEach(groupDataByDay(healthData: healthData, keyPath: \.bloodPressureSystolic), id: \.date) { data in
                    HStack {
                        // Format by the day of the week
                        Text("\(data.date, formatter: DateFormatter.dayOfWeekFormatter):")
                        Text("\(data.values.map(String.init).joined(separator: "/"))")

                    }
                }
            }
            
            // Same as the systolic section but for the diastolic BP
            Section(header: Text("Blood Pressure Diastolic")) {
                ForEach(groupDataByDay(healthData: healthData, keyPath: \.bloodPressureDiastolic), id: \.date) { data in
                    HStack {
                        Text("\(data.date, formatter: DateFormatter.dayOfWeekFormatter):")
                        Text("\(data.values.map(String.init).joined(separator: "/"))")

                    }
                }
            }
            
            // Get the weights of the user over the week and output the values for each day
            Section(header: Text("Weight")) {
                ForEach(groupDataByDay(healthData: healthData, keyPath: \.weightPounds), id: \.date) { data in
                    HStack {
                        Text("\(data.date, formatter: DateFormatter.dayOfWeekFormatter):")
                        Text("\(data.values.reduce(0, +) / Double(data.values.count), specifier: "%.1f") lbs")
                    }
                }
            }
            
            // Section for the morning sugar levels
            // Works the same way as the other ones
            Section(header: Text("Morning Sugar Level")) {
                ForEach(groupDataByDay(healthData: healthData, keyPath: \.morningSugarLevel), id: \.date) { data in
                    HStack {
                        Text("\(data.date, formatter: DateFormatter.dayOfWeekFormatter):")
                        Text("\(data.values.reduce(0, +) / Double(data.values.count), specifier: "%.1f")")
                    }
                }
            }
        }
        //Title for the navigation view
        .navigationTitle("My Health")
    }

    // Group the data
    // function to group health data by day, based on a given keyPath
    func groupDataByDay<T>(healthData: [HealthData], keyPath: KeyPath<HealthData, T>) -> [GroupedData<T>] where T: Hashable {
        
        // Create a dictionary that groups the health data by day
        let groupedByDay = Dictionary(grouping: healthData) { data in
            Calendar.current.startOfDay(for: data.date)
        }
        // Sort the keys in the dictionary in descending order
        let sortedKeys = groupedByDay.keys.sorted(by: >)
        
        // Map the sorted keys to GroupedData objects, with the date as the key and the values as an array of the given keyPath property for each HealthData object in that day's group
        let groupedData = sortedKeys.map { key in
            GroupedData(date: key, values: groupedByDay[key]!.map { data in data[keyPath: keyPath] })
        }
        
        // Return the array of GroupedData objects
        return groupedData
    }
}

// Structure for the grouped data
struct GroupedData<T: Hashable>: Identifiable {
    let date: Date
    let values: [T]
    var id: Date { date }
}

// Extension found online to format the dates
extension DateFormatter {
    static let dayOfWeekFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
}
