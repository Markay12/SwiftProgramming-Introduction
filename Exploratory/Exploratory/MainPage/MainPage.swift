//
//  MainPage.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/11/23.
//

import SwiftUI
import MapKit
import FirebaseAuth
import FirebaseDatabase

// MARK: Begin Main View
struct MainPage: View {
    
    // App Storage to get user information
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var usernameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""

    @ObservedObject private var viewModel = MapViewModel()
    @ObservedObject private var statsViewModel = StatisticsViewModel()

    
    @State private var alert: Alert?
    
    @State var timer: Timer?

    
    public func showAlert(_ alert: Alert) {
        self.alert = alert
    }
    
    public func hideAlert() {
        alert = nil
    }
    
    // code for sheets per button
    @State private var showFriendsSheet = false
    @State private var showHistorySheet = false
    @State private var showStatsSheet = false
    @State private var showSettingsSheet = false
    
    init()
    {
        viewModel.checkIfLocationServicesEnabled()
        viewModel.startUpdatingLocation()
        listenForLocationChanges()
    }

    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            
            // MARK: Begin Showing Map
            // This code is creating a Map view with the region as a binding variable, and showing the user's location
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .ignoresSafeArea()
                .accentColor(Color.orange)
                // Alert is displayed if the viewModel.alert value is set
                .alert(item: $viewModel.alert) { alert in
                    alert.alert
                }
    
                // The entire Map view is offset by -200 in the y-axis
                .offset(y: -200)
    
                // A VStack overlay is added to the Map view
                .overlay(
                    VStack(spacing: 10) {
                        // If the viewModel.weather value is not nil,       temperature, weather description, and a cloud icon     are displayed
                        if let weather = viewModel.weather {
                            Text("\(Int(weather.main.temp))°F")
                                .foregroundColor(.black)
                                .font(.title)
    
                            Text(weather.weather.first?.description.capitalized     ?? "")
                                .foregroundColor(.black)
                                .font(.caption)
    
                            Image(systemName: "cloud.fill")
                                .foregroundColor(.black)
                                .font(.system(size: 30))
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .offset(y: -20)
                    , alignment: .top
                )


            
            // MARK: Begin UI Rectangles
            

            
            Rectangle()
                .fill(Color.black)
                .frame(width: 395, height: 425)
                .cornerRadius(20)
                .padding(.horizontal)
                .padding(.bottom, -50)
                .overlay(
                    VStack(alignment: .leading) {
                        
                        
                        Text("Welcome Back!")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.bottom, -2.5)
                            .bold()
                            .underline()
                            .offset(x: 20, y: 7)

                        Text("Where shall we begin today?")
                            .font(.headline)
                            .padding(.bottom)
                            .foregroundColor(.white)
                            .offset(x: 20, y: 7)

                        
                        LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 15) {
                            Button(action: {
                                showFriendsSheet = true
                            }) {
                                VStack(spacing: 5) {
                                    Image(systemName: "person.circle.fill")
                                        .font(.system(size: 40))
                                        .foregroundColor(.black)
                                    Text("Friends")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .bold()
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(20)
                            }
                            .buttonStyle(TallButtonStyle())
                            .sheet(isPresented: $showFriendsSheet, onDismiss: {
                                
                                // set to false so we can open more sheets
                                showFriendsSheet = false
                            })
                            {
                                // Show the friends sheet
                                FriendsView()
                                
                            }
                            
                            Button(action: {
                                showHistorySheet = true
                            }) {
                                VStack(spacing: 5) {
                                    Image(systemName: "clock.circle.fill")
                                        .font(.system(size: 40))
                                        .foregroundColor(.black)
                                    Text("History")
                                        .font(.headline)
                                        .bold()
                                        .foregroundColor(.black)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(20)
                            }
                            .buttonStyle(TallButtonStyle())
                            .sheet(isPresented: $showHistorySheet, onDismiss: {
                                // set to false so we can open more sheets
                                showHistorySheet = false
                                
                            })
                            {
                                // Open the History view
                                HistoryView()
                            }
                            
                            Button(action: {
                                showStatsSheet = true
                            }) {
                                VStack(spacing: 5) {
                                    Image(systemName: "chart.pie.fill")
                                        .font(.system(size: 40))
                                        .foregroundColor(.black)
                                    Text("Statistics")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .bold()
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(20)
                            }
                            .buttonStyle(TallButtonStyle())
                            .sheet(isPresented: $showStatsSheet, onDismiss: {
                                // set to false so we can open more sheets
                                showStatsSheet = false
                            })
                            {
                                StatisticsView()
                            }
                            
                            Button(action: {
                                showSettingsSheet = true
                                
                            }) {
                                VStack(spacing: 5) {
                                    Image(systemName: "gear.circle.fill")
                                        .font(.system(size: 40))
                                        .foregroundColor(.black)
                                    Text("Settings")
                                        .font(.headline)
                                        .bold()
                                        .foregroundColor(.black)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(20)
                            }
                            .buttonStyle(TallButtonStyle())
                            .sheet(isPresented: $showSettingsSheet, onDismiss: {
                                // set to false so we can open more sheets
                                showSettingsSheet = false
                            })
                            {
                                
                                SettingsView()

                            }
                        }
                        .padding(.horizontal, 20)


                    }
                        .padding()
                        
                )
        }
    }
    
    // MARK: Save Location to DB
    // Save user's location data to Realtime Database
    func saveLocation(latitude: Double, longitude: Double) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let locationRef = Database.database().reference().child("locations").child(userUID)
        locationRef.setValue(["latitude": latitude, "longitude": longitude])
    }
    
    
    // MARK: Listen for Changes
    // Listen for user's location data changes in Realtime Database
    func listenForLocationChanges() {
        guard let userUID = Auth.auth().currentUser?.uid else {
            return
        }

        let locationRef = Database.database().reference().child("locations").child(userUID)

        locationRef.observe(.value) { snapshot, _ in
            DispatchQueue.global(qos: .background).async {
                guard let locationData = snapshot.value as? [String: Double],
                    let latitude = locationData["latitude"],
                    let longitude = locationData["longitude"] else {
                        return
                }

                // Update user's location on the map
                DispatchQueue.main.async {
                    viewModel.updateUserLocation(latitude: latitude, longitude: longitude)
                }
            }
        }
    }

}


// MARK: Extensions for all Views
extension View {
    
    func hAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func disableWithOpacity(_ condition: Bool) -> some View {
        
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
    
}


struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
