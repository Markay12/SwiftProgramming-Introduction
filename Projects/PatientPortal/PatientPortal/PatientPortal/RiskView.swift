//
//  RiskView.swift
//  PatientPortal
//
//  Created by Mark Ashinhust on 3/24/23.
//

import SwiftUI

import SwiftUI

struct RiskView: View {
    let healthData: [HealthData]
    
    var body: some View {
        let weightRisk = calculateWeightRisk()
        let sugarRisk = calculateSugarRisk()
        let bpRisk = calculateBPRisk()
        let isAtRisk = weightRisk || sugarRisk || bpRisk
        
        VStack {
            
            // If at risk, shows a red exclamation to let the user know that they are at risk
            if isAtRisk {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.red)
                    .padding(.bottom)
            } else {
                // show a smile if the user is not at risk
                Image(systemName: "face.smiling.inverse")
                    .font(.system(size: 60))
                    .foregroundColor(.green)
                    .padding(.bottom)
            }
            
            // If at risk, show the first message, else show the other.
            Text(isAtRisk ? "You may be at risk!" : "You are in good health, keep up the good work!")
                .font(.headline)
                .padding(.bottom)
                .bold()
            
            // Determines what the risk is
            if weightRisk {
                Text("Your weight is higher in the last four days compared to the first three days of the week!")
                    .foregroundColor(.red)
                    .padding(.bottom)
                
            }
            
            if sugarRisk {
                Text("Your sugar level is 10% higher than the previous day!")
                    .foregroundColor(.red)
                    .padding(.bottom)
            }
            
            if bpRisk {
                Text("Your blood pressure is 10% higher than the previous day!")
                    .foregroundColor(.red)
                    .padding(.bottom)
            }
        }
        .padding()
        .navigationTitle("Am I at Risk?")
    }
    
    // This function calculates the weight risk of the patient based on the last four days of the week.
    // It returns true if the average weight of the last four days is higher than the average weight of the first three days.
    // Otherwise, it returns false.
    // If there are less than 7 records in the health data, the function will return false.
    // Parameters:
    // None
    // Returns:
    // A boolean value indicating whether the patient is at weight risk.
    
    private func calculateWeightRisk() -> Bool {
        if (healthData.count > 6)
        {
            let sortedData = healthData.sorted { $0.date < $1.date }
            let firstThreeDaysData = sortedData.prefix(3)
            let lastFourDaysData = sortedData.suffix(4)
            let firstThreeDaysWeight = firstThreeDaysData.map { $0.weightPounds }.reduce(0, +) /    Double(firstThreeDaysData.count)
            let lastFourDaysWeight = lastFourDaysData.map { $0.weightPounds }.reduce(0, +) /    Double(lastFourDaysData.count)
            return lastFourDaysWeight > firstThreeDaysWeight
        }
        else { return false }
    }
    
    // This function calculates the sugar risk by checking if the current sugar level is 10% higher than the previous day
    private func calculateSugarRisk() -> Bool {
        guard healthData.count >= 2 else { return false }
        let sortedData = healthData.sorted { $0.date < $1.date }
        let currentSugarLevel = sortedData.last!.morningSugarLevel
        let previousSugarLevel = sortedData[sortedData.count - 2].morningSugarLevel
        let percentChange = (currentSugarLevel - previousSugarLevel) / previousSugarLevel
        return percentChange > 0.1
    }
    
    
    //This function calculates whether the user is at risk for high blood pressure by comparing the current systolic and diastolic blood pressure readings with the previous day's readings. It returns a boolean value indicating whether the percent change in either reading is greater than 10%
    private func calculateBPRisk() -> Bool {
        guard healthData.count >= 2 else { return false }
        let sortedData = healthData.sorted { $0.date < $1.date }
        let currentSystolic = sortedData.last!.bloodPressureSystolic
        let previousSystolic = sortedData[sortedData.count - 2].bloodPressureSystolic
        let currentDiastolic = sortedData.last!.bloodPressureDiastolic
        let previousDiastolic = sortedData[sortedData.count - 2].bloodPressureDiastolic
        let percentChangeSystolic = Float( (currentSystolic - previousSystolic) / previousSystolic)
        let percentChangeDiastolic = Float((currentDiastolic - previousDiastolic) / previousDiastolic)
        
        return percentChangeSystolic > 0.1 || percentChangeDiastolic > 0.1

    }
}

