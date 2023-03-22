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
            Section(header: Text("Blood Pressure")) {
                ForEach(groupDataByDay(healthData: healthData, keyPath: \.bloodPressureSystolic), id: \.date) { data in
                    HStack {
                        Text("\(data.date, formatter: DateFormatter.dayOfWeekFormatter):")
                        Text("\(data.values.map(String.init).joined(separator: "/"))")

                    }
                }
            }
            Section(header: Text("Weight")) {
                ForEach(groupDataByDay(healthData: healthData, keyPath: \.weightPounds), id: \.date) { data in
                    HStack {
                        Text("\(data.date, formatter: DateFormatter.dayOfWeekFormatter):")
                        Text("\(data.values.reduce(0, +) / Double(data.values.count), specifier: "%.1f") lbs")
                    }
                }
            }
            Section(header: Text("Morning Sugar Level")) {
                ForEach(groupDataByDay(healthData: healthData, keyPath: \.morningSugarLevel), id: \.date) { data in
                    HStack {
                        Text("\(data.date, formatter: DateFormatter.dayOfWeekFormatter):")
                        Text("\(data.values.reduce(0, +) / Double(data.values.count), specifier: "%.1f")")
                    }
                }
            }
        }
        .navigationTitle("My Health")
    }

    func groupDataByDay<T>(healthData: [HealthData], keyPath: KeyPath<HealthData, T>) -> [GroupedData<T>] where T: Hashable {
        let groupedByDay = Dictionary(grouping: healthData) { data in
            Calendar.current.startOfDay(for: data.date)
        }
        let sortedKeys = groupedByDay.keys.sorted(by: >)
        let groupedData = sortedKeys.map { key in
            GroupedData(date: key, values: groupedByDay[key]!.map { data in data[keyPath: keyPath] })
        }
        return groupedData
    }
}

struct GroupedData<T: Hashable>: Identifiable {
    let date: Date
    let values: [T]
    var id: Date { date }
}

extension DateFormatter {
    static let dayOfWeekFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
}
