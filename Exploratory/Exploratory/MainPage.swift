//
//  MainPage.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/11/23.
//

import SwiftUI
import MapKit

struct MainPage: View {
    
    @StateObject private var viewModel = MapViewModel()
    
    // Beginning location data at Arizona State University Tempe
    // Span of 0.005 to be closer to the users location
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 33.42348546947854, longitude: -111.9314781482712),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    
    
    var body: some View {
        
        // Show the map
        // Show user location if permission is given
        Map(coordinateRegion: $region, showsUserLocation: true)
            .ignoresSafeArea() // Remove the borders
        
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // Need location manager to use maps
    // Optional value in case the user has their location services turned off
    var locationManager:  CLLocationManager?
    
    // Check to make sure the location services are enables
    func checkIfLocationServicesEnabled() {
        if CLLocationManager.locationServicesEnabled()
        {
            
            // True, so create the location manager
            locationManager = CLLocationManager()
            
            // Desired user location accuracy
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            
        }
        else
        {
            
            print("Alert that the location is turned off and they should turn it on.")
            
        }
    }
    
    // Get authorization for location from the user
    func checkLocationAuthorization()
    {
        
        guard let locationManager = locationManager else { return }
        
        // Check for all auth cases
        switch locationManager.authorizationStatus {
            
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Show alert about location")
            case .denied:
                print("This app cannot access your location. Please allow location data.")
            case .authorizedAlways, .authorizedWhenInUse:
                break
            @unknown default:
                break
        }
        
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // If location management has changed we want to check the authorization again
        checkLocationAuthorization()
    }
    
    
}
