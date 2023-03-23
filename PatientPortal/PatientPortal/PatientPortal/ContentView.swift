//
//  ContentView.swift
//  PatientPortal
//
//  Created by Mark Ashinhust on 3/22/23.
//

import SwiftUI

struct ContentView: View {
    @State var healthData: [HealthData] = []
    @State var showAddView = false

    var body: some View {
        NavigationView {
            List {
                if healthData.isEmpty {
                    Text("No health data found.")
                } else {
                    Section(header: Text("Health Summary")) {
                        NavigationLink(destination: HealthSummary(healthData: healthData)) {
                            Text("View my health")
                        }
                    }
                    Section(header: Text("Recent Data")) {
                        ForEach(healthData.prefix(3), id: \.date) { data in
                            HealthDataRow(data: data)
                                
                        }
                        
                    }
                    
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Patient Portal")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showAddView = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showAddView) {
                AddData(healthData: $healthData)
            }
        }
    }
}

struct HealthDataRow: View {
    let data: HealthData

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(data.date, formatter: DateFormatter.dateFormatter)")
            Text("BP: \(data.bloodPressureSystolic)/\(data.bloodPressureDiastolic), Weight: \(data.weightPounds, specifier: "%.1f") lbs, Sugar: \(data.morningSugarLevel, specifier: "%.1f")")
                .font(.headline)
        }
    }
}



extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
