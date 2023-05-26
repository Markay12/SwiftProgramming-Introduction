//
//  ContentView.swift
//  PatientPortal
//
//  Created by Mark Ashinhust on 3/22/23.
//

import SwiftUI

struct ContentView: View {
    
    // Variable the hold the health data of individuals
    @State var healthData: [HealthData] = []
    
    // whether or not to show the add or risk views
    @State var showAddView = false
    @State var showRiskView = false

    // main view body
    var body: some View {
        // Navigation view
        NavigationView {
            List {
                
                // if there is no data in the list, show that there is no health data
                if healthData.isEmpty {
                    Text("No health data found.")
                        .foregroundColor(Color.red)
                } else {
                    // Show the health summary with a section if the user has input data for their health
                    Section(header: Text("Health Summary")) {
                        NavigationLink(destination: HealthSummary(healthData: healthData)) {
                            Text("View my health")
                        }
                    }
                    
                    // Section to show the recent data, up to the most recent seven days
                    Section(header: Text("Recent Data")) {
                        ForEach(healthData.prefix(7), id: \.date) { data in
                            HealthDataRow(data: data)
                                
                        }
                        
                    }
                    
                }
            }
            // Grouped list style
            .listStyle(GroupedListStyle())
            
            // Navigation View title
            .navigationBarTitle("Patient Portal")
            
            // show the buttons for the user to control their view. Can add information and/or view if they are at risk or not
            .navigationBarItems(trailing:
                HStack {
                    Button(action: {
                        self.showRiskView = true
                    }) {
                        Image(systemName: "exclamationmark.triangle")
                    }
                    Button(action: {
                        self.showAddView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            )
            
            // conditionals that choose which view to show based off the button that is clicked
            .sheet(isPresented: $showAddView) {
                AddData(healthData: $healthData)
            }
            .sheet(isPresented: $showRiskView) {
                RiskView(healthData: healthData)
            }
        }
    }
}

// Structure that stores the health data of individuals
struct HealthDataRow: View {
    let data: HealthData

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(data.date, formatter: DateFormatter.dateFormatter)")
            Text("BP: \(data.bloodPressureSystolic)/\(data.bloodPressureDiastolic) mmHg, Weight: \(data.weightPounds, specifier: "%.1f") lbs, Sugar: \(data.morningSugarLevel, specifier: "%.1f") mg/dL")
                .font(.headline)
        }
    }
}

// Extension to format the datetime

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
}

// Show preview for debugging

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
