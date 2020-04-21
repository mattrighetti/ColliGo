//
//  ContentView.swift
//  ColliGo
//
//  Created by Mattia Righetti on 21/04/2020.
//  Copyright © 2020 Mattia Righetti. All rights reserved.
//

import SwiftUI

struct Store: Identifiable, Hashable {
    let id: UUID = UUID()
    let title: String
    let address: String
    let city: String
    let categories: [String]
    let kilometres: Double
}

struct StoresView: View {
    
    @State var showShopInfoModal: Bool = false
    
    var stores: [Store] = [
        Store(title: "Salumeria di Mario Rossi", address: "Piazzale Lagosta", city: "Milano", categories: ["Salumeria"], kilometres: 2.3),
        Store(title: "Vino Vino dal 1921", address: "Corso San Gottardo, 123", city: "Roma", categories: ["Salumeria"], kilometres: 0.3),
        Store(title: "Gli Olivi di Etruria APS", address: "Via G. Contadini 55", city: "Montefiascone", categories: ["Oleoteca", "Gastronomia"], kilometres: 0.3),
        Store(title: "Il Forno di Via Commenda", address: "Via Della Commenda, 21", city: "Venezia", categories: ["Panificio", "Pasticcieria", "Alimentari"], kilometres: 6.4),
        Store(title: "Salumeria di Mario Rossi", address: "Piazzale Lagosta", city: "Catania", categories: ["Salumeria"], kilometres: 5.0),
        Store(title: "Giovanni Galli", address: "Via Victor Hugo", city: "Verona", categories: ["Cioccolateria"], kilometres: 9.3),
        Store(title: "Dal 1964 Enoteca EL VINATT", address: "Via Leone Tolstoi 49", city: "Milano", categories: ["Enoteca", "Alimentari", "Birroteca"], kilometres: 12.5),
        Store(title: "Zabbara | Eccellenze Siciliane", address: "Via Saluzzo 49/d", city: "Torino", categories: ["Gastronomia"], kilometres: 1.4)
    ]
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(named: "background")
        UITableView.appearance().separatorColor = UIColor(named: "background")
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(stores, id: \.self) { store in
                    StoreRow(title: store.title, address: store.address, city: store.city, categories: store.categories, kilometres: store.kilometres)
                        .onTapGesture(perform: {
                            self.showShopInfoModal.toggle()
                        })
                        .listRowBackground(Color("background"))
                }
            }
        
        .navigationBarTitle("Negozi")
        }
        .sheet(isPresented: $showShopInfoModal) {
            StoreView()
        }
    }
    
    
    
}

struct StoreRow: View {
    
    var title: String
    var address: String
    var city: String
    var categories: [String]
    var kilometres: Double
    
    var body: some View {
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
                    ForEach(categories, id: \.self) { category in
                        CategoryPill(categoryName: category)
                    }
                }
            }
        }
    }
}

struct StoresView_Previews: PreviewProvider {
    static var previews: some View {
        StoresView().environment(\.colorScheme, .dark)
    }
}

struct CategoryPill: View {
    
    var categoryName: String
    var fontSize: CGFloat = 12.0
    
    var body: some View {
        ZStack {
            Text(categoryName)
                .font(.system(size: fontSize, weight: .regular))
                .foregroundColor(.white)
                .padding(5)
                .background(Color.green)
                .cornerRadius(15)
        }
    }
}
