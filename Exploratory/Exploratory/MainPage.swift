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
                .frame(width: 395, height: 400)
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

                        Text("Where shall we begin today?")
                            .font(.headline)
                            .padding(.bottom)
                            .foregroundColor(.white)

            
                        
                        HStack
                        {
                            Button(action: {
                                // Action for button
                            }) {
                                Text("Find Places")
                                    .font(.headline)
                                    .foregroundColor(.orange)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    
                                
                            }
                            
                            Button(action: {
                                // Action for button
                            }) {
                                Text("Find Places")
                                    .font(.headline)
                                    .foregroundColor(.orange)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                
                            }
                            
                        }
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
