//
//  CityDetailView.swift
//  Lab5_MapData
//
//  Created by Mark Ashinhust on 3/21/23.
//

import SwiftUI
import MapKit



struct CityDetailView: View {
    
    let city: City
    
    @State private var latitude: CLLocationDegrees = 0
    @State private var longitude: CLLocationDegrees = 0
    
    @State private var search = ""
    

    var body: some View {
        ZStack
        {
            
            VStack{
                
                
                
                MapView(cityName: city.name, latitude: $latitude, longitude: $longitude, search: $search)
                    .scaledToFill()
                    .offset(y: -150)
                    .padding(.horizontal)
                
            
                
            }
            .navigationTitle(city.name)
            
            Rectangle()
                .fill(LinearGradient(colors: [.red, .black], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 400, height: 350)
                .cornerRadius(40)
                .offset(y: 250)
            
            SearchBar(text: $search)
                .padding()
                .offset(y: 300)
                .frame(width: 400, height: 20)
                .background(LinearGradient(colors: [.white, .gray, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 375, height: 60)
                    .cornerRadius(18)
                    .offset(y: 300)
                    )
            
            
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

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search"
        searchBar.autocapitalizationType = .none
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = false
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}



struct MapView: UIViewRepresentable {
    let cityName: String
    @Binding var latitude: CLLocationDegrees
    @Binding var longitude: CLLocationDegrees
    @Binding var search: String

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator

        // Set up map region and annotation
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(cityName) { (placemarks, error) in
            if let placemark = placemarks?.first {
                let annotation = MKPointAnnotation()
                annotation.coordinate = placemark.location!.coordinate
                annotation.title = cityName
                mapView.addAnnotation(annotation)

                self.latitude = placemark.location!.coordinate.latitude
                self.longitude = placemark.location!.coordinate.longitude

                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
                mapView.setRegion(region, animated: true)
            }
        }

        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = search
        
        let span = view.region.span
        let center = view.region.center
        let region = MKCoordinateRegion(center: center, span: span)
        searchRequest.region = region
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let response = response, error == nil else {
                return
            }
            
            view.removeAnnotations(view.annotations)
            
            let annotations = response.mapItems.map { item -> MKAnnotation in
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                return annotation
            }
            
            view.addAnnotations(annotations)
        }
    }

    func makeCoordinator() -> MapViewCoordinator
    {
        
        MapViewCoordinator(parent: self)
    }
}

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    
    var parent: MapView
    
    init(parent: MapView) {
        self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        annotationView.canShowCallout = true
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        _ = mapView.region.span
        let center = mapView.region.center
        self.parent.latitude = center.latitude
        self.parent.longitude = center.longitude
    }
}








struct CityDetailView_Previews: PreviewProvider
{
    static var previews: some View {
        CityDetailView(city: City(name: "Chiacgo", description: "The city of brotherly love", image: "philadelphia"))
    }
}

