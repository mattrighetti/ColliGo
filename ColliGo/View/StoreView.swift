//
//  StoreView.swift
//  ColliGo
//
//  Created by Mattia Righetti on 21/04/2020.
//  Copyright © 2020 Mattia Righetti. All rights reserved.
//

import SwiftUI

struct StoreView: View {
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            VStack {
                Image(systemName: "chevron.compact.down")
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text("Gli Olivi di Etruria APS")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .layoutPriority(1)
                    
                    HStack {
                        CategoryPill(categoryName: "Oleoteca", fontSize: 20)
                        CategoryPill(categoryName: "Gastronomia", fontSize: 20)
                        Spacer()
                    }
                    
                    Text("Dalle Terre di Etruria, Olio EVO di Eccellenza e Prodotti Locali")
                            .font(.headline)
                            .fontWeight(.regular)
                            .lineLimit(3)
                            .padding(.bottom, 20)
                    
                    Text("Pages").font(.title).fontWeight(.bold)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            VStack {
                                Image(systemName: "globe").font(.largeTitle)
                                    .frame(width: 50, height: 50)
                                Text("Website")
                            }.padding()
                            
                            VStack {
                                Image("facebook").resizable().frame(width: 50, height: 50)
                                Text("Facebook Page")
                            }.padding()
                            
                            Spacer()
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Contacts").font(.title).fontWeight(.bold)
                        
                        HStack {
                            Image("telegram")
                                .resizable()
                                .frame(width: 50, height: 50)
                            
                            Text("3333333333").font(.headline)
                        }
                        
                        HStack {
                            Image("phone")
                                .resizable()
                                .frame(width: 50, height: 50)
                            
                            Text("3333333333").font(.headline)
                        }
                        
                        HStack {
                            Image("whatsapp")
                                .resizable()
                                .frame(width: 50, height: 50)
                            
                            
                            Text("3333333333").font(.headline)
                        }
                        
                        HStack {
                            Image("messenger")
                                .resizable()
                                .frame(width: 50, height: 50)
                            
                            Text("3333333333").font(.headline)
                        }
                    }
                    
                }.padding()
            }
        }
    }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
            .environment(\.colorScheme, .dark)
    }
}
