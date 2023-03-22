//
//  SplashScreenViewController.swift
//  PatientPortal
//
//  Created by Mark Ashinhust on 3/22/23.
//

import SwiftUI

struct SplashScreenViewController: View {
    var body: some View {
        ZStack
        {
            
            VStack
            {
                
                Image("hospital-logo")
                    .resizable()
                    .scaledToFit()
                    .offset(y: -100)
                    
                
                
                Text("Patient Portal")
                    .font(.title)
                    .bold()
                    .offset(y: -100)
                                    
            }
            
            
        }
        
        
    }
}

struct SplashScreenViewController_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenViewController()
    }
}
