//
//  ContentView.swift
//  FirebaseLoginAuthentication
//
//  Created by Mark Ashinhust on 3/16/23.
//

import SwiftUI

// Extension to use hex colors
extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}


struct ContentView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        
        ZStack
        {
            
            Color.black
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(
                    colors: [
                        Color(hex: 0xC1121F),
                        Color(hex: 0xf77f00),
                        Color(hex: 0xfcbf49)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 1000, height: 400)
                .rotationEffect(.degrees(140))
                .offset(y: -300)

            VStack(spacing: 20)
            {
                
                Text("Sign In")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -100, y: -150)
                                
                TextField("Email", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                
                
                
            }
            .frame(width: 350)

            
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
