//
//  SplashScreen.swift
//  ColliGo
//
//  Created by Mattia Righetti on 23/04/2020.
//  Copyright © 2020 Mattia Righetti. All rights reserved.
//

import SwiftUI

struct Feature {
    let imageName: String
    let featureTitle: String
    let featureDescription: String
}

struct SplashScreen: View {
    
    var features: [Feature] = [
        Feature(imageName: "undraw_destination", featureTitle: "Trova il negozio che cerchi\nsulla mappa", featureDescription: ""),
        Feature(imageName: "undraw_directions", featureTitle: "La lista iniziale\ntimostrerà i negozi\na te più vicini", featureDescription: ""),
        Feature(imageName: "undraw_mobile_messages", featureTitle: "Contatta comodamente\nil commerciante", featureDescription: ""),
        Feature(imageName: "undraw_online_messaging", featureTitle: "Ordina la spesa\ne accordati per l'orario\ndi ritiro", featureDescription: ""),
        Feature(imageName: "undraw_personal_information", featureTitle: "L'applicazione ti mostrerà quali canali di comunicazione sono disponibili per ogni negozio", featureDescription: "")
    ]
    
    @State var currentFeature: Int = 0
    @Binding var isModalShown: Bool
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            VStack {
                Image(systemName: "chevron.compact.down").padding()
                Spacer()
                FeatureView(feature: features[currentFeature])
                Spacer()
                generateButton().padding()
                Spacer()
                HStack {
                    Circle()
                        .fill(currentFeature == 0 ? Color.green : Color.gray)
                        .frame(width: 5, height: 5, alignment: .center)
                    
                    Circle()
                        .fill(currentFeature == 1 ? Color.green : Color.gray)
                        .frame(width: 5, height: 5, alignment: .center)
                    
                    Circle()
                        .fill(currentFeature == 2 ? Color.green : Color.gray)
                        .frame(width: 5, height: 5, alignment: .center)
                    
                    Circle()
                        .fill(currentFeature == 3 ? Color.green : Color.gray)
                        .frame(width: 5, height: 5, alignment: .center)
                    
                    Circle()
                        .fill(currentFeature == 4 ? Color.green : Color.gray)
                        .frame(width: 5, height: 5, alignment: .center)
                }
            }
        }.gesture(
            DragGesture(minimumDistance: 10, coordinateSpace: .global)
                .onEnded({ value in
                    if value.translation.width < 0 && self.currentFeature < self.features.count - 1 {
                        self.currentFeature += 1
                        print(value.translation.width)
                        print(self.currentFeature)
                    } else if value.translation.width > 0 && self.currentFeature > 0 {
                        self.currentFeature -= 1
                        print(self.currentFeature)
                    }
                })
        )
    }
    
    func generateButton() -> AnyView {
        self.currentFeature == 4 ?
        AnyView(
            Button(action: {
                self.isModalShown.toggle()
            }, label: {
                Text("Avanti")
            })
        )
        :
        AnyView(EmptyView())
    }
    
}

struct FeatureView: View {
    
    var feature: Feature
    
    var body: some View {
        VStack {
            Text(feature.featureTitle).font(.title).multilineTextAlignment(.center).padding()
            Image(feature.imageName)
                .resizable()
                .scaledToFit()
                .padding(50)
            
            Text(feature.featureDescription).font(.caption).multilineTextAlignment(.center)
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    @State private static var show: Bool = true
    static var previews: some View {
        SplashScreen(isModalShown: $show).environment(\.colorScheme, .dark)
    }
}
