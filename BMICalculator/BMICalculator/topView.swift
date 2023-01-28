//
//  topView.swift
//  BMICalculator
//
//  Created by Mark Ashinhust on 1/27/23.
//

import SwiftUI

struct topView: View {
    
    
    // declare global variables
    // set as string and convert later
    @State private var heightInches:String = ""
    @State private var weightLbs:String = ""
    @State public var bmiText = "Your Current BMI is: "
    @State public var bmi = ""
    @State public var colorText = ""
    @State public var resultText = ""
    
    var getBmi : Double {
        
        guard let height = Double(heightInches), let weight = Double(weightLbs) else { return 0 }
        
        return (weight / (height * height)) * 703
        
    }
    

    var body: some View {
        
        
        
        VStack(alignment: .center, spacing: 20) {
            
            // H Stack for the Height information
            HStack
            {
                
                // HStack for the Height
                
                Spacer(minLength: 10)
                
                Text("Enter Height: ")
                
                // text field for input and value manipulation
                TextField(
                    "Required",
                    text: $heightInches,
                    onEditingChanged: { (changed) in print("heightInches onEditingChanged -\(changed)");
                        self.resultText = "";
                        self.bmi = ""
                        
                    }
                    
                )
                .textFieldStyle(.roundedBorder)
                
                Spacer(minLength: 10)
            }
            
            HStack
            {
                
                // HStack for the weight
                
                Spacer(minLength: 10)
                
                Text("Enter Weight: ")
                
                // text field for input and value manipulation
                TextField(
                    "Required",
                    text: $weightLbs,
                    onEditingChanged: { (changed) in print("weightLbs onEditingChanged -\(changed)");
                        self.resultText = "";
                        self.bmi = ""
                    }
                    
                    
                    
                )
                .textFieldStyle(.roundedBorder)
                
                Spacer(minLength: 10)
                
                
            }
            
            
            
            Button(action: {
                
                self.bmi = String("\(getBmi)")
                
                print(bmi)
                
                let count = getBmi
                
                switch count {
                    
                case 0...17:
                    
                    self.resultText = ("You are Underweight!")
                        
                    
                case 18...24:
                    self.resultText = ("You are Normal Weight!")
                
                    
                case 25...30:
                    self.resultText = ("You are Pre-Obese!")
                        
                    
                case 31..<10000:
                    self.resultText = ("You are Obese!")
                        
                
                default:
                    
                    self.resultText = ("")
                    
                }
                
                
                
            }) {
                
                //button text
                Text("Click Me!")
                
            }
            .buttonStyle(.bordered)
            
            Text(bmiText)
            Text(bmi)
                    
            let count = getBmi
            
            switch count
            {
            
            case 1...17:
                Text(resultText)
                    .foregroundColor(.blue)
                    .font(.title)
                    .bold()
                
            case 18...24:
                Text(resultText)
                    .foregroundColor(.green)
                    .font(.title)
                    .bold()
                
            case 25...30:
                Text(resultText)
                    .foregroundColor(.purple)
                    .font(.title)
                    .bold()
                
            case 30...1000:
                Text(resultText)
                    .foregroundColor(.red)
                    .font(.title)
                    .bold()
                    .underline()
                
                
            default:
                
                Text(resultText)
                    .foregroundColor(.white)
                
            
            }
            
            
           
            
        }
    }
}

struct topView_Previews: PreviewProvider {
    static var previews: some View {
        topView()
        
        
    }
}
