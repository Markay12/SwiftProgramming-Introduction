//
//  ContentView.swift
//  BMICalculator
//
//  Created by Mark Ashinhust on 1/27/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
                
        NavigationView {
            VStack {
                Spacer()
                                
                NavigationLink(destination: topView())
                {
                    
                    Text("BMI Text Input Calculator!")
                    
                }
                .buttonStyle(.bordered)
                    .background(.blue)
                    .padding()
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    
                    
                
                Spacer()
                
                NavigationLink(destination: bottomView())
                {
                    
                    Text("BMI Slider Calculator!")
                    
                }
                .buttonStyle(.bordered)
                    .background(.orange)
                    .padding()
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                
                Spacer()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
