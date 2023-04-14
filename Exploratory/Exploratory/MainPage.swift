//
//  MainPage.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/11/23.
//

import SwiftUI
import MapKit

struct MainPage: View {
    
    @ObservedObject private var viewModel = MapViewModel()
    
    @State private var alert: Alert?
    
    public func showAlert(_ alert: Alert) {
        self.alert = alert
    }
    
    public func hideAlert() {
        alert = nil
    }
    
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
            
            Rectangle()
                .fill(Color.black.opacity(0.85))
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
                                // Action for button
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
                            
                            Button(action: {
                                // Action for button
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
                            
                            Button(action: {
                                // Action for button
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
                            
                            Button(action: {
                                // Action for button
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
