//
//  Buttons.swift
//  Lab3_MarkAshinhust
//
//  Created by Mark Ashinhust on 2/24/23.
//

import Foundation
import SwiftUI

public struct MyButtonStyleBlue: ButtonStyle {
    var backgroundColor: Color = .blue
    var cornerRadius: CGFloat = 12.0
    var buttonWidth: CGFloat = 100.0
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

public struct MyButtonStyleOrange: ButtonStyle {
    var backgroundColor: Color = .orange
    var cornerRadius: CGFloat = 12.0
    var buttonWidth: CGFloat = 100.0
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}


public struct MyButtonStyleGreen: ButtonStyle {
    var backgroundColor: Color = .green
    var cornerRadius: CGFloat = 12.0
    var buttonWidth: CGFloat = 100.0
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

public struct MyButtonStyleRed: ButtonStyle {
    var backgroundColor: Color = .red
    var cornerRadius: CGFloat = 12.0
    var buttonWidth: CGFloat = 100.0

    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct SearchTextStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 0.2)
            )
            .foregroundColor(.black)
    }
}

