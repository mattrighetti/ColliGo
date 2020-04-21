//
//  HomeView.swift
//  ColliGo
//
//  Created by Mattia Righetti on 21/04/2020.
//  Copyright © 2020 Mattia Righetti. All rights reserved.
//

import SwiftUI
import MapKit
import ColliGoShopModel

struct HomeView: View {
    
    @ObservedObject var shopsViewModel: ShopsViewModel = ShopsViewModel()
    @ObservedObject var locationManager: LocationManager
    
    var body: some View {
        TabView {
            StoresView(
                shopsViewModel: self.shopsViewModel,
//                userLat: locationManager.lastLocation!.coordinate.latitude,
                userLat: 41.9028,
//                userLng: locationManager.lastLocation!.coordinate.longitude
                userLng: 12.4964
            )
            .tabItem {
                Image(systemName: "house")
                Text("Shops")
            }
            
            MapView(
                shopsViewModel: self.shopsViewModel,
//                userLat: locationManager.lastLocation!.coordinate.latitude,
                userLatitude: 41.9028,
//                userLng: locationManager.lastLocation!.coordinate.longitude
                userLongitude: 12.4964
            )
            .tabItem {
                Image(systemName: "map")
                Text("Map")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(locationManager: LocationManager()).previewDevice("iPhone 11")
    }
}
