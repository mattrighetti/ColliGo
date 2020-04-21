//
//  MapView.swift
//  ColliGo
//
//  Created by Mattia Righetti on 21/04/2020.
//  Copyright © 2020 Mattia Righetti. All rights reserved.
//

import SwiftUI
import MapKit
import ColliGoShopModel

struct MapView: UIViewRepresentable {
    
    @ObservedObject var shopsViewModel: ShopsViewModel
    
    var userLatitude: CLLocationDegrees
    var userLongitude: CLLocationDegrees
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let currentLocation = CLLocationCoordinate2D(latitude: userLatitude, longitude: userLongitude)
        let coordinateRegion = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(shopsViewModel: ShopsViewModel(), userLatitude: 41.0, userLongitude: 41.0)
    }
}
