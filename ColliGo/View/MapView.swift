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
    
    @EnvironmentObject var locationManager: LocationManager
    @ObservedObject var shopsViewModel: ShopsViewModel
    
    var annotations: [MKPointAnnotation] {
        var array = [MKPointAnnotation]()
        
        self.shopsViewModel.shops.forEach({ shop in
            let annotation = MKPointAnnotation()
            annotation.title = shop.name
            annotation.subtitle = shop.address
            annotation.coordinate = CLLocationCoordinate2D(latitude: shop.lat!, longitude: shop.lng!)
            array.append(annotation)
        })
        
        return array
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "map_pin")
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
        
//        let currentLocation = CLLocationCoordinate2D(latitude: locationManager.lastLocation!.coordinate.latitude, longitude: locationManager.lastLocation!.coordinate.longitude)
//        let coordinateRegion = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 5000, longitudinalMeters: 5000)
//        mapView.setRegion(coordinateRegion, animated: true)
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.annotations.forEach({ annotation in
                mapView.showAnnotations(annotations, animated: true)
//                mapView.addAnnotation(annotation)
//            })
//        }
        
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(shopsViewModel: ShopsViewModel())
    }
}
