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
    
    var userLatitude: CLLocationDegrees
    var userLongitude: CLLocationDegrees
    
    var body: some View {
        TabView {
            StoresView(shopsViewModel: shopsViewModel, userLat: userLatitude, userLng: userLongitude)
                .tabItem {
                    Image(systemName: "house")
                    Text("Shops")
                }
            
            MapView(shopsViewModel: self.shopsViewModel, userLatitude: userLatitude, userLongitude: userLongitude)
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(userLatitude: 41.0, userLongitude: 41.0).previewDevice("iPhone 11")
    }
}
