//
//  bottomView.swift
//  BMICalculator
//
//  Created by Mark Ashinhust on 1/27/23.
//

import SwiftUI

struct bottomView: View {
    
    @State private var heightSlider = 0.0
    @State private var weightSlider = 0.0
    @State private var isEditingHeight = false
    @State private var isEditingWeight = false

    
    var body: some View {
        
        VStack(alignment: .center, spacing: 50)
        {
            
            // Individual Vstack for slider
            VStack
            {
                
                
                Text("Slide to the appropriate Height:")
                    .foregroundColor(.black)
                    .bold()
                
                Slider(value: $heightSlider,
                       in: 1...100,
                       step: 1,
                       onEditingChanged:{ (changed) in print("heightInches onEditingChanged -\(heightSlider)" );
                      isEditingHeight = changed
                        }
                ) .padding()
                
                Text("\(heightSlider)")
                    .foregroundColor(isEditingHeight ? .blue : .green)
                    
                
            }
            
            VStack
            {
                
                Text("Slide to the appropriate Weight:")
                    .foregroundColor(.black)
                    .bold()
                
                Slider(value: $weightSlider,
                       in: 0...350,
                       step: 5,
                       onEditingChanged:{ (changed) in print("weightLbs onEditingChanged -\(weightSlider)" );
                      isEditingWeight = changed
                        }
                ) .padding()
                
                Text("\(weightSlider)")
                    .foregroundColor(isEditingWeight ? .blue : .green)
                    
                
            }
                
            
        }
        
        Spacer()
        
        // case statement to print what you are
        
        let bmi = (weightSlider / (heightSlider * heightSlider)) * 730
        
        switch bmi
        {
            
        case 1...17:
            Text("You are Underweight!")
                .foregroundColor(.blue)
                .font(.title)
                .bold()
            
        case 18...24:
            Text("You are Normal Weight!")
                .foregroundColor(.green)
                .font(.title)
                .bold()
            
        case 25...30:
            Text("You are Pre-Obese!")
                .foregroundColor(.purple)
                .font(.title)
                .bold()
            
        case 30...10000000:
            Text("You are Obese!")
                .foregroundColor(.red)
                .font(.title)
                .bold()
            
        default:
            Text("BMI is Zero")
                .bold()
                .foregroundColor(.red)
                .font(.title)
            
        }
        
        
        
    }
}

struct bottomView_Previews: PreviewProvider {
    static var previews: some View {
        bottomView()
    }
}
