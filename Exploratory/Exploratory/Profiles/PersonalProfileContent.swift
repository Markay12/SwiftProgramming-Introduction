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
import FirebaseFirestore
import FirebaseAuth

struct PersonalProfileContent: View {
    
    // MARK: Declare variables
    @State private var location = Location(city: "", state: "", country: "")
    @State private var bioText = ""
    
    @StateObject private var statisticsViewModel = StatisticsViewModel()
    
    
    @State private var showAlert = false
        
    // Maximum number of characters allowed in bio
    let maxBioLength = 140
    
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
                        
                        Text(user.userBio)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .lineLimit(4)
                        
                        
                        Text("Cities Visited: \(statisticsViewModel.citiesVisited)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("Countries Visited:\(statisticsViewModel.countriesVisited)")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Text("Distance Traveled: \(statisticsViewModel.distanceTraveled,specifier: "%.2f") km")
                            .font(.caption)
                            .foregroundColor(.gray)

                        
                                                
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
                            .offset(y: -20)
                        }
                    }
                }
                
                Section(header: Text("Personal Bio")
                    .font(.title2)
                    .underline()
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .hAlign(.leading)
                    .padding(.vertical, 15)
                ) {
                    VStack(alignment: .leading, spacing: 6) {
                        TextField("Enter your personal bio...", text: $bioText)
                            .textFieldStyle(.roundedBorder)
                        
                        HStack {
                            Spacer()
                            Button("Save") {
                                                                
                                if bioText.count > maxBioLength {
                                    
                                
                                    showAlert = true
                                } else {
                                    saveBio()
                                    
                                }
                            }
                            .buttonStyle(.borderless)
                            .controlSize(.small)
                            .offset(y: -100)
                        }
                    }
                    .padding(.vertical, 15)
                }
                
            }
            .padding(15)
        }
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            reverseGeocode()
        }
        .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Bio too long"),
                    message: Text("Your bio can't exceed \(maxBioLength) characters."),
                    dismissButton: .default(Text("OK"))
                )
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
    //MARK: Hide the Keyboard
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func saveBio() {
        
        // Update the bio in Firebase Firestore
        guard let userUID = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore()
        let userRef = db.collection("Users").document(userUID)
        userRef.updateData([
            "userBio": bioText
            
        ]) { error in
            if let error = error {
                print("Error updating user bio: \(error.localizedDescription)")
            } else {
                hideKeyboard()
                bioText = ""
                print("User bio updated successfully")
            }
        }
    }

    
}



struct Location {
    var city: String
    var state: String
    var country: String
}



struct PersonalProfileContent_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}

