//
//  Styles.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/13/23.
//

import Foundation
import SwiftUI


struct TallButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 130, height: 120)
            .background(Color.white)
            .cornerRadius(20)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}
