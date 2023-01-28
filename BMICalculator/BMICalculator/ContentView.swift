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
                
                Text("BMI Calculator App")
                    .font(.largeTitle)
                    .bold()
                    .underline()
                Text("Developed by Mark Ashinhust")
                Text("28 January 2023")
                
                Spacer()
                                
                NavigationLink(destination: topView())
                {
                    
                    Label("Text Input Calculator", systemImage: "number.square")
                    
                }
                .buttonStyle(.bordered)
                .background(.blue)
                .padding()
                .foregroundColor(.white)
                
                    
                    
                
                Spacer()
                
                NavigationLink(destination: bottomView())
                {
                    
                    Label("Slider Input Calculator", systemImage: "number.square.fill")
                    
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
