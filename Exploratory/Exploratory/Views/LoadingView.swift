//
//  LoadingView.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/15/23.
//

import SwiftUI

struct LoadingView: View {
    
    // MARK: Declaration of Variables
    @Binding var show: Bool
    
    
    // MARK: Begin Main View
    var body: some View {
        ZStack
        {
            if show
            {
                // Group rectangle and progress for animation
                Group {
                    Rectangle()
                        .fill(.black.opacity(0.25))
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .padding(15)
                        .background(.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            }
        }
        // Begin animation
        .animation(.easeInOut(duration: 0.25), value: show)
    }
}

