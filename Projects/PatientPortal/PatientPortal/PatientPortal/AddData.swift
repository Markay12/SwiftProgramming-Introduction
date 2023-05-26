//
//  AddData.swift
//  PatientPortal
//
//  Created by Mark Ashinhust on 3/22/23.
//

import SwiftUI

struct AddData: View {
    @Binding var healthData: [HealthData]
    @Environment(\.presentationMode) var presentationMode  // Add this variable
    @State var selectedDate = Date()
    @State var bloodPressureSystolic = ""
    @State var bloodPressureDiastolic = ""
    @State var weightPounds = ""
    @State var morningSugarLevel = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Date")) {
                    DatePicker("Select date", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                }
                Section(header: Text("Blood Pressure")) {
                    HStack {
                        TextField("Systolic", text: $bloodPressureSystolic)
                            .keyboardType(.numberPad)
                        Text("/")
                        TextField("Diastolic", text: $bloodPressureDiastolic)
                            .keyboardType(.numberPad)
                    }
                }
                Section(header: Text("Weight")) {
                    TextField("Weight (lbs)", text: $weightPounds)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Morning Sugar Level")) {
                    TextField("Sugar level (mg/dL)", text: $morningSugarLevel)
                        .keyboardType(.decimalPad)
                }
                Section {
                    Button("Save") {
                        if let systolic = Int(bloodPressureSystolic),
                            let diastolic = Int(bloodPressureDiastolic),
                            let weight = Double(weightPounds),
                            let sugar = Double(morningSugarLevel),
                            !bloodPressureSystolic.isEmpty,
                            !bloodPressureDiastolic.isEmpty,
                            !weightPounds.isEmpty,
                            !morningSugarLevel.isEmpty
                        {
                            let data = HealthData(date: selectedDate,
                                                    bloodPressureSystolic: systolic,
                                                    bloodPressureDiastolic: diastolic,
                                                    weightPounds: weight,
                                                    morningSugarLevel: sugar)
                            healthData.append(data)
                            bloodPressureSystolic = ""
                            bloodPressureDiastolic = ""
                            weightPounds = ""
                            morningSugarLevel = ""
                            presentationMode.wrappedValue.dismiss() // Dismiss the view
                        }
                    }
                }
            }
            .navigationBarTitle("Add Health Data")
        }
    }
}

