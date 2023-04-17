//
//  PersonalProfileContent.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/17/23.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

// Import Location data for user
import CoreLocation
import MapKit


struct PersonalProfileContent: View {
    
    // MARK: Declare variables
    @State private var location = Location(city: "", state: "", country: "")

    var user: User
    
    // To track user location
    @State private var locationManager = CLLocationManager()
    
    //String for city

    
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
                        
                        Text(user.userEmail)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                                                
                    }
                    .hAlign(.leading)
                    
                }
                
                Section(header: Text("User Locations")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .hAlign(.leading)
                    .padding(.vertical, 15)
                ) {
                    Group {
                        Text("Current Location")
                            .font(.title3)
                            .underline()
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .hAlign(.leading)
                            .padding(.vertical, 15)
                        
                        if location.city.isEmpty {
                            Text("Location not available")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .hAlign(.leading)
                                .padding(.vertical, 15)
                        } else {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(location.city)
                                    .fontWeight(.semibold)
                                
                                Text("\(location.state), \(location.country)")
                                    .foregroundColor(.gray)
                            }
                            .hAlign(.leading)
                            .padding(.vertical, 15)
                        }
                    }
                }

                
            }
            .padding(15)
        }
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            reverseGeocode()
        }



        

    }
    
    func reverseGeocode() {
        if let location = locationManager.location {
            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                if let placemark = placemarks?.first {
                    let city = placemark.locality ?? ""
                    let state = placemark.administrativeArea ?? ""
                    let country = placemark.country ?? ""
                    self.location = Location(city: city, state: state, country: country)
                }
            }
        }
    }


    

    
}


struct Location {
    var city: String
    var state: String
    var country: String
}


