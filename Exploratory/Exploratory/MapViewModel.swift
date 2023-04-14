//
//  MapViewModel.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/13/23.
//

import SwiftUI
import MapKit

enum MapDetails
{
    
    static let startingLocation = CLLocationCoordinate2D(latitude: 33.42348546947854, longitude:-111.9314781482712)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // Beginning location data at Arizona State University Tempe
    // Span of 0.005 to be closer to the users location
    // Published so can be used
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation,
                                               span: MapDetails.defaultSpan)
    
    // Need location manager to use maps
    // Optional value in case the user has their location services turned off
    var locationManager:  CLLocationManager?
    
    // Check to make sure the location services are enables
    var showAlert: ((Alert) -> Void)?
    
    @Published var alert: AlertItem?
    
    enum AlertItem: Identifiable {
        case locationServicesDisabled
        case locationPermissionDenied
        
        var id: String {
            switch self {
            case .locationServicesDisabled:
                return "Location Services Disabled"
            case .locationPermissionDenied:
                return "Location Permission Denied"
            }
        }
        
        var alert: Alert {
            switch self {
            case .locationServicesDisabled:
                return Alert(
                    title: Text("Location Services Disabled"),
                    message: Text("Please turn on location services in Settings to use this app"),
                    dismissButton: .default(Text("OK"))
                )
            case .locationPermissionDenied:
                return Alert(
                    title: Text("Location Permission Denied"),
                    message: Text("This app cannot access your location. Please allow location data."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    func checkIfLocationServicesEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.delegate = self
        } else {
            alert = .locationServicesDisabled
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            alert = .locationPermissionDenied
        case .denied:
            alert = .locationPermissionDenied
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate,
                                        span: MapDetails.defaultSpan)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // If location management has changed we want to check the authorization again
        checkLocationAuthorization()
    }
    
}
