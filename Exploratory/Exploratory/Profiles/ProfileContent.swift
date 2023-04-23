//
//  ProfileContent.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/16/23.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct ProfileContent: View {
    
    var user: User
    
    var body: some View {

        ScrollView(.vertical, showsIndicators: false)
        {
            LazyVStack {
                HStack (spacing: 12)
                {
                    
                    // MARK: Display user image
                    WebImage(url: user.userProfileURL).placeholder
                    {
                        // Placeholder Image for the user
                        Image("GeneralProfileImage")
                            .resizable()
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    
                    // MARK: User text and information
                    VStack(alignment: .leading, spacing: 6)
                    {
                        // Username Text
                        Text(user.username)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("Bio: \(user.userBio)")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .lineLimit(3)
                        
                        Text("Visited Cities: \(user.citiesVisited)")
                            .font(.caption)
                            .foregroundColor(.gray)
                            
                        Text("Visited Countries: \(user.countriesVisited)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Text("Distance Traveled: \(user.distanceTraveled, specifier: "%.2f") km")
                            .font(.caption)
                            .foregroundColor(.gray)
                                                
                    }
                    .hAlign(.leading)
                    
                }
                
                Text("User Locations")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .hAlign(.leading)
                    .padding(.vertical, 15)
                
            }
            .padding(15)
        }
        

    }
    

    
}

