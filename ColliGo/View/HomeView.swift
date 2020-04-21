//
//  HomeView.swift
//  ColliGo
//
//  Created by Mattia Righetti on 21/04/2020.
//  Copyright © 2020 Mattia Righetti. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            StoresView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Shops")
                }
            
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().previewDevice("iPhone 11")
    }
}
