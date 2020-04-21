//
//  ContentView.swift
//  ColliGo
//
//  Created by Mattia Righetti on 21/04/2020.
//  Copyright © 2020 Mattia Righetti. All rights reserved.
//

import SwiftUI
import ColliGoShopModel
import MapKit

struct StoresView: View {
    
    init(shopsViewModel: ShopsViewModel, userLat: CLLocationDegrees, userLng: CLLocationDegrees) {
        UITableView.appearance().backgroundColor = UIColor(named: "background")
        UITableView.appearance().separatorColor = UIColor(named: "background")
        self.userLatitude = userLat
        self.userLongitude = userLng
        self.shopViewModel = shopsViewModel
    }
    
    @ObservedObject var shopViewModel: ShopsViewModel
    @State var showShopInfoModal: Bool = false
    @State var selectedShop = 0
    
    var userLatitude: CLLocationDegrees
    var userLongitude: CLLocationDegrees
    
    var body: some View {
        NavigationView {
            generateView()
        
        .navigationBarTitle("Negozi")
        }
        .sheet(isPresented: $showShopInfoModal) {
            StoreView(shop: self.shopViewModel.filteredShops.filter({ $0.id == self.selectedShop })[0])
        }
        .onAppear {
            if !self.shopViewModel.fetchedOnce {
                self.shopViewModel.fetchShops(currLat: self.userLatitude, currLng: self.userLongitude)
            }
        }
    }
    
    func generateView() -> AnyView {
        while shopViewModel.fetching {
            return showFetching()
        }
        
        if shopViewModel.filteredShops.count > 0 {
            return showList()
        } else {
            return notifyNoShopAvailable()
        }
        
    }
    
    func showFetching() -> AnyView {
        return AnyView(
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                Text("Sto ottenendo i dati...")
            }
        )
    }
    
    func showList() -> AnyView {
        return AnyView(
            List {
                ForEach(shopViewModel.filteredShops, id: \.id) { shop in
                    StoreRow(
                        title: shop.name,
                        address: shop.address!,
                        city: shop.city!,
                        categories: shop.categories,
                        kilometres: shop.distance!
                    )
                    .onTapGesture {
                        self.showShopInfoModal.toggle()
                        self.selectedShop = shop.id
                    }
                    .listRowBackground(Color("background"))
                }
            }
        )
    }
    
    func notifyNoShopAvailable() -> AnyView {
        return AnyView(
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                VStack {
                    Image(systemName: "mappin.slash")
                        .font(.system(size: 50))
                        .padding()
                    
                    Text("Non sono disponibili negozi nella tua zona").font(.headline)
                }
            }
        )
    }
    
}

struct StoreRow: View {
    
    var title: String
    var address: String
    var city: String
    var categories: [ColliGoShopModel.Category]
    var kilometres: Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color("cardBackground")
            HStack {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.lightRed, .darkRed]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    VStack {
                        Text("\(kilometres.oneDecimalPrecision)").font(.system(size: 20, weight: .bold)).foregroundColor(.white)
                        Text("km").font(.caption).foregroundColor(.white)
                    }
                }.frame(width: 70, height: 70, alignment: .center)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .padding(.bottom, 5)
                    
                    Text(address)
                        .padding(.bottom, 5)
                    
                    HStack(alignment: .center) {
                        Image(systemName: "mappin")
                        Text(city)
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        ForEach(categories, id: \.id) { category in
                            CategoryPill(categoryName: category.name!)
                        }
                    }
                }.padding(.horizontal, 5)
            }.padding(15)
        }.clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct CategoryPill: View {
    
    var categoryName: String
    var fontSize: CGFloat = 12.0
    
    var body: some View {
        ZStack {
            Text(categoryName)
                .font(.system(size: fontSize, weight: .regular))
                .lineLimit(2)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.green)
                .cornerRadius(5)
        }
    }
}

struct StoresView_Previews: PreviewProvider {
    static var previews: some View {
        StoresView(shopsViewModel: ShopsViewModel(), userLat: 41.0, userLng: 41.0).environment(\.colorScheme, .dark)
    }
}
