//
//  StoreView.swift
//  ColliGo
//
//  Created by Mattia Righetti on 21/04/2020.
//  Copyright © 2020 Mattia Righetti. All rights reserved.
//

import SwiftUI
import ColliGoShopModel

struct StoreView: View {
    
    var shop: Shop
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            VStack {
                Image(systemName: "chevron.compact.down").padding()
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text(shop.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .layoutPriority(1)
                    
                    HStack {
                        ForEach(shop.categories, id: \.self.name) { category in
                            CategoryPill(categoryName: category.name!, fontSize: 15)
                        }
                        Spacer()
                            
                    }
                    
                    Text(shop.description ?? "")
                            .font(.headline)
                            .fontWeight(.regular)
                            .lineLimit(3)
                            .padding(.bottom, 20)
                    
                    Text("Pages").font(.title).fontWeight(.bold)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            generateWebsiteIcon()
                            generateFacebookIcon()
                            Spacer()
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Contacts").font(.title).fontWeight(.bold)
                        
                        HStack {
                            generatePhoneIcon()
                            generateTelegramIcon()
                            generateWhatsappIcon()
                            generateMessengerIcon()
                        }
                    }
                }.padding()
                Spacer()
            }
        }
    }
    
    func generateWebsiteIcon() -> AnyView {
        guard let url = shop.facebook else {
            return AnyView(EmptyView())
        }
        
        return AnyView(
            VStack {
                Image(systemName: "globe").font(.largeTitle)
                    .frame(width: 50, height: 50)
                Text("Website")
            }
            .padding()
            .onTapGesture {
                UIApplication.shared.open(URL(string: url)!)
            }
        )
    }
    
    func generateFacebookIcon() -> AnyView {
        guard let url = shop.facebook else {
            return AnyView(EmptyView())
        }
        
        return AnyView(
            VStack {
                Image("facebook")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("Facebook Page")
            }
            .padding()
            .onTapGesture {
                UIApplication.shared.open(URL(string: url)!)
            }
        )
    }
    
    func generateTelegramIcon() -> AnyView {
        guard let url = shop.telegram else {
            return AnyView(EmptyView())
        }
        
        return AnyView(
            Image("telegram")
                .resizable()
                .frame(width: 50, height: 50)
                .padding()
                .onTapGesture {
                    UIApplication.shared.open(URL(string: url)!)
                }
        )
    }
    
    func generateWhatsappIcon() -> AnyView {
        guard let url = shop.whatsapp else {
            return AnyView(EmptyView())
        }
        
        return AnyView(
            Image("whatsapp")
                .resizable()
                .frame(width: 50, height: 50)
                .padding()
                .onTapGesture {
                    UIApplication.shared.open(URL(string: url)!)
                }
        )
    }
    
    func generateMessengerIcon() -> AnyView {
        guard let url = shop.messenger else {
            return AnyView(EmptyView())
        }
        
        return AnyView(
            Image("messenger")
                .resizable()
                .frame(width: 50, height: 50)
                .padding()
                .onTapGesture {
                    UIApplication.shared.open(URL(string: url)!)
                }
        )
    }
    
    func generatePhoneIcon() -> AnyView {
        guard var url = shop.phone else {
            return AnyView(EmptyView())
        }
        
        url = "tel://" + url
        
        return AnyView(
            Image("phone")
                .resizable()
                .frame(width: 50, height: 50)
                .padding()
                .onTapGesture {
                    UIApplication.shared.open(URL(string: url)!)
                }
        )
    }
    
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView(shop: Shop.starter)
            .environment(\.colorScheme, .dark)
    }
}
