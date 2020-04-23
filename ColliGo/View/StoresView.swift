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
import Combine

struct StoresView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    @ObservedObject var shopViewModel: ShopsViewModel
    @State var showShopInfoModal: Bool = false
    @State var selectedShop = 0
    @State var waitingForLastLocation = true
    
    init(shopsViewModel: ShopsViewModel) {
        UITableView.appearance().backgroundColor = UIColor(named: "background")
        UITableView.appearance().separatorColor = UIColor(named: "background")
        self.shopViewModel = shopsViewModel
    }
    
    var body: some View {
        NavigationView {
            generateView()
        
        .navigationBarTitle("Negozi")
        .navigationBarItems(trailing: AnyView(
            Button(action: {
                self.waitingForLastLocation.toggle()
                self.locationManager.askUserPermission()
            }, label: {
                Image(systemName: "arrow.2.circlepath")
            })
        ))
        }
        .sheet(isPresented: $showShopInfoModal) {
            StoreView(shop: self.shopViewModel.filteredShops.filter({ $0.id == self.selectedShop })[0])
        }
        .onAppear {
            self.locationManager.$lastLocation.sink { value in
                if let coordinates = value {
                    print(coordinates.coordinate.latitude)
                    print(coordinates.coordinate.longitude)
                    self.shopViewModel.fetchShops(
                        currLat: coordinates.coordinate.latitude,
                        currLng: coordinates.coordinate.longitude
                    )
                    self.waitingForLastLocation.toggle()
                }
            }.store(in: &self.shopViewModel.subscriptions)
        }
    }
    
    func generateView() -> AnyView {
        while (shopViewModel.fetching || waitingForLastLocation) && !(shopViewModel.fetchedOnce) {
            print("fetching -> " + String(shopViewModel.fetching))
            print("waiting -> " + String(waitingForLastLocation))
            return showLoading()
        }
        
        if shopViewModel.filteredShops.count > 0 {
            return showList()
        } else {
            return notifyNoShopAvailable()
        }
    }
    
    func showLoading() -> AnyView {
        return AnyView(
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                VStack {
                    Text(waitingForLastLocation ? "Ottengo la posizione" : "Ottengo i negozi")
                    LottieView(lottieAnimation: "blue-preloader").frame(width: 100, height: 100, alignment: .center)
                }
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
                        .padding(20)
                    
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
        StoresView(shopsViewModel: ShopsViewModel()).environment(\.colorScheme, .dark)
    }
}
