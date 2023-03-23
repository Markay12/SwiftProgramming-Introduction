//
//  CityDetailView.swift
//  Lab5_MapData
//
//  Created by Mark Ashinhust on 3/21/23.
//

import SwiftUI
import MapKit



struct CityDetailView: View {
    
    // city defined as a City object
    let city: City
    
    // Get location coordinates to print to the screen
    @State private var latitude: CLLocationDegrees = 0
    @State private var longitude: CLLocationDegrees = 0
    
    // Search location provided by the user for food etc.
    @State private var search = ""
    
    // Main view for this screen
    var body: some View {
        ZStack
        {
            
            // Hold information for the Map View that takes up most of the screen
            
            VStack{
                
                MapView(cityName: city.name, latitude: $latitude, longitude: $longitude, search: $search)
                    .scaleEffect(1.25)
                    .padding(.horizontal)
                
                
            }
            
            // Black Rectangle to place information and to put the search bar
            Rectangle()
                .fill(.black)
                .frame(width: 400, height: 350)
                .cornerRadius(40)
                .offset(y: 250)
            
            // Search bar for the user to look up locations in the area like Coffee, Tea etc.
            SearchBar(text: $search)
                .padding()
                .offset(y: 300)
                .frame(width: 400, height: 20)
                .background(LinearGradient(colors: [.white, .gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 375, height: 60)
                    .cornerRadius(18)
                    .offset(y: 300)
                    )
            
            
            // Information about the city, description, lat and long data
            VStack
            {
                
                Text(city.name)
                    .offset(y: 150)
                    .foregroundColor(.white)
                    .bold()
                    .font(.title)
                    .underline()
                
                Text("Description: \(city.description)")
                    .offset(y: 175)
                    .foregroundColor(.white)
                    .font(.body)
                    .lineLimit(nil)
                    .minimumScaleFactor(0.5)
                
                
                Text("Latitude: \(latitude), Longitude: \(longitude)")
                    .foregroundColor(.white)
                    .font(.body)
                    .offset(y: 200)
   
                
            }
        }
        
        
    }
}

// Structure for the Search bar that will update the map to show specific things around the area.
struct SearchBar: UIViewRepresentable {
    
    // String that is entered by the user
    @Binding var text: String
    
    // Delegate coordinator for the application
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        // text comes out of the string from the user
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
    // The search bar User Interface which shows the user how to input their information
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search (ex. Pizza, Coffee)"
        searchBar.autocapitalizationType = .none
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = false
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}


// Map View Structure for the user to see locations
// Information here taken from Module on MapView

struct MapView: UIViewRepresentable {
    
    // get name of the city
    let cityName: String
    
    // City location values
    @Binding var latitude: CLLocationDegrees
    @Binding var longitude: CLLocationDegrees
    
    // Pass in search to search around the first city location
    @Binding var search: String

    func makeUIView(context: Context) -> MKMapView {
        // Create map view
        let mapView = MKMapView()
        
        // Show location that we are moving to
        mapView.showsUserLocation = true
        
        // Update delegate as we move to locations
        mapView.delegate = context.coordinator

        // Set up map region and annotation
        let geocoder = CLGeocoder()
        
        // Convert the city name to a location and retrieve its placemark
        geocoder.geocodeAddressString(cityName) { (placemarks, error) in
            if let placemark = placemarks?.first {
                
                // Create a new annotation for the city
                let annotation = MKPointAnnotation()
                annotation.coordinate = placemark.location!.coordinate
                annotation.title = cityName
                mapView.addAnnotation(annotation)
                
                // Update the latitude and longitude values
                self.latitude = placemark.location!.coordinate.latitude
                self.longitude = placemark.location!.coordinate.longitude

                // Set the map region to focus on the city
                // 0.05 so we start more zoomed in
                
                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
                mapView.setRegion(region, animated: true)
            }
        }

        return mapView
    }

    // update the UIView
    // This function is used to update the MKMapView when the search query changes.
    func updateUIView(_ view: MKMapView, context: Context) {
        // Create a new search request with the current search query
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = search
        
        // Set the search request region to the current visible region of the map
        let span = view.region.span
        let center = view.region.center
        let region = MKCoordinateRegion(center: center, span: span)
        searchRequest.region = region
        
        // Perform the search using the search request and add the results to the map view
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let response = response, error == nil else {
                return
            }
            
            // Remove all existing annotations from the map view
            view.removeAnnotations(view.annotations)
            
            // Create new annotations for each search result and add them to the map view
            let annotations = response.mapItems.map { item -> MKAnnotation in
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                return annotation
            }
            
            view.addAnnotations(annotations)
        }
    }

    // Constructor to create the coordinator
    func makeCoordinator() -> MapViewCoordinator
    {
        
        MapViewCoordinator(parent: self)
    }
}

// Coordinator for the MapView SwiftUI view.
class MapViewCoordinator: NSObject, MKMapViewDelegate {
    
    // The parent MapView instance that this coordinator is associated with
    var parent: MapView
    
    // Initialize the coordinator with the parent MapView instance
    init(parent: MapView) {
        self.parent = parent
    }
    
    // Implement the MKMapViewDelegate method to provide a view for each annotation on the map
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        annotationView.canShowCallout = true
        return annotationView
    }
    
    // Implement the MKMapViewDelegate method to update the latitude and longitude values when the map region changes
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        _ = mapView.region.span
        let center = mapView.region.center
        self.parent.latitude = center.latitude
        self.parent.longitude = center.longitude
    }
}


// Generic City view for testing
struct CityDetailView_Previews: PreviewProvider
{
    static var previews: some View {
        CityDetailView(city: City(name: "Tempe", description: "Arizona State University!", image: "philadelphia"))
    }
}

