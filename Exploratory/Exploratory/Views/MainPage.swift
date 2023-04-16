//
//  MainPage.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/11/23.
//

import SwiftUI
import MapKit

struct MainPage: View {
    
    // App Storage to get user information
    @AppStorage("user_name") var usernameStored: String = ""

    @ObservedObject private var viewModel = MapViewModel()
    
    @State private var alert: Alert?
    
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

    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .ignoresSafeArea()
                .accentColor(Color.orange)
                .alert(item: $viewModel.alert) { alert in
                    alert.alert
                }
                .onAppear {
                    viewModel.checkIfLocationServicesEnabled()
                }
                .offset(y: -200)
            
            Rectangle()
                .fill(Color.black)
                .frame(width: 395, height: 425)
                .cornerRadius(20)
                .padding(.horizontal)
                .padding(.bottom, -50)
                .overlay(
                    VStack(alignment: .leading) {
                        Text("Welcome Back \(usernameStored)!")
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
    
}



struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
