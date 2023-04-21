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
import FirebaseFirestore
import Combine

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
    
    func fetchStats() {
        guard let currentUser = Auth.auth().currentUser else { return }

        let db = Firestore.firestore()
        let docRef = db.collection("statistics").document(currentUser.uid)

        docRef.getDocument { (document, error) in
            if let error = error {
                print("Error fetching statistics: \(error)")
            } else if let document = document, document.exists {
                if let data = document.data() {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                        let stats = try JSONDecoder().decode(Statistics.self, from: jsonData)
                        DispatchQueue.main.async {
                            self.citiesVisited = stats.citiesVisited
                            self.countriesVisited = stats.countriesVisited
                            self.distanceTraveled = stats.distanceTraveled
                        }
                    } catch let error {
                        print("Error decoding statistics: \(error)")
                    }
                } else {
                    print("Document does not exist")
                }
            } else {
                print("Document does not exist")
            }
        }
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
        
        // Update travel history in Realtime Database
        let travelHistoryRef = databaseRef.child("users").child(userId).child("travelHistory")
        let travelHistoryDict: [String: Any] = [
            "citiesVisited": citiesVisited,
            "countriesVisited": countriesVisited,
            "distanceTraveled": distanceTraveled
        ]
        travelHistoryRef.setValue(travelHistoryDict) { [weak self] (error, _) in
            guard error == nil else { return }
            
            // Update the view when the data is written to the database
            DispatchQueue.main.async {
                self?.fetchTravelHistory()
            }
        }
        
        // Update travel history in Firestore
        let db = Firestore.firestore()
        let userRef = db.collection("Users").document(userId)
        userRef.updateData([
            "citiesVisited": citiesVisited,
            "countriesVisited": countriesVisited,
            "distanceTraveled": distanceTraveled
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
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
