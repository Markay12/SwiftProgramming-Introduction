//
//  StatisticsViewModel.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/19/23.
//

import CoreLocation
import Foundation
import FirebaseDatabase
import FirebaseAuth

class StatisticsViewModel: NSObject, ObservableObject {
    @Published var citiesVisited = 0
    @Published var countriesVisited = 0
    @Published var distanceTraveled = 0.0 // Initialize to zero
    
    private let locationManager = CLLocationManager()
    private var previousLocation: CLLocation?
    
    private let databaseRef = Database.database().reference()
    private let userId = Auth.auth().currentUser?.uid
    
    override init() {
        super.init()
        
        // Set up location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .fitness
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Fetch travel history from the database
        fetchTravelHistory()
    }
    
    private func fetchTravelHistory() {
        guard let userId = userId else { return }
        let travelHistoryRef = databaseRef.child("users").child(userId).child("travelHistory")
        travelHistoryRef.observeSingleEvent(of: .value) { [weak self] (snapshot) in
            guard let self = self else { return }
            
            let travelHistoryDict = snapshot.value as? [String: Any] ?? [:]
            self.citiesVisited = travelHistoryDict["citiesVisited"] as? Int ?? 0
            self.countriesVisited = travelHistoryDict["countriesVisited"] as? Int ?? 0
            self.distanceTraveled = travelHistoryDict["distanceTraveled"] as? Double ?? 0.0
        }
    }
    
    private func updateTravelHistory() {
        guard let userId = userId else { return }
        let travelHistoryRef = databaseRef.child("users").child(userId).child("travelHistory")
        
        let travelHistoryDict: [String: Any] = [
            "citiesVisited": citiesVisited,
            "countriesVisited": countriesVisited,
            "distanceTraveled": distanceTraveled
        ]
        
        travelHistoryRef.setValue(travelHistoryDict) { [weak self] (error, _) in
            guard error == nil, let self = self else { return }
            
            // Update the view when the data is written to the database
            DispatchQueue.main.async {
                self.fetchTravelHistory()
            }
        }
    }
    
    private func updateDistanceTraveled(to newLocation: CLLocation) {
        guard let previousLocation = previousLocation else {
            self.previousLocation = newLocation
            return
        }
        
        let distance = newLocation.distance(from: previousLocation)
        distanceTraveled += distance / 1000 // Convert to km
        self.previousLocation = newLocation
        
        updateTravelHistory()
    }
}

extension StatisticsViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        updateDistanceTraveled(to: location)
    }
}
