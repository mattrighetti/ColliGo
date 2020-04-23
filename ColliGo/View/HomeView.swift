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
    @EnvironmentObject var locationManager: LocationManager
    
    @State var showLocationManagerNotAuthorized: Bool = true
    @State var showSplashscreen: Bool
    
    var body: some View {
        TabView {
            locationManager.hasAuth ?
                Group {
                    generateStoresView(withAuth: true)
                    .tabItem {
                        Image(systemName: "house")
                        Text("Shops")
                    }
                    
                    generateMapView(withAuth: true)
                    .tabItem {
                        Image(systemName: "map")
                        Text("Map")
                    }
                }
            :
                Group {
                    generateStoresView(withAuth: false)
                    .tabItem {
                        Image(systemName: "house")
                        Text("Shops")
                    }
                    
                    generateMapView(withAuth: false)
                    .tabItem {
                        Image(systemName: "map")
                        Text("Map")
                    }
                }
        }.sheet(isPresented: $showSplashscreen, onDismiss: {
            self.locationManager.askUserPermission()
            UserDefaults.standard.set(true, forKey: "splashScreenShown")
        }, content: {
            SplashScreen(isModalShown: self.$showSplashscreen)
        }).onAppear {
            if !self.showSplashscreen {
                self.locationManager.askUserPermission()
            }
        }
    }
    
    func generateStoresView(withAuth auth: Bool) -> AnyView {
        if auth {
            return AnyView(
                StoresView(
                    shopsViewModel: self.shopsViewModel
                )
            )
        }
        
        return AnyView(
            ZStack {
                Color("background")
                Text("The app needs your location to work properly")
            }
        )
    }
    
    func generateMapView(withAuth auth: Bool) -> AnyView {
        if auth {
            return AnyView(
                MapView(
                    shopsViewModel: self.shopsViewModel
                )
            )
        }
        
        return AnyView(
            Text("The app needs your location to work properly")
        )
    }
    
}

#if DEBUG
var locationManager: LocationManager = LocationManager()

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showSplashscreen: true).environmentObject(locationManager).previewDevice("iPhone 11")
    }
}
#endif
