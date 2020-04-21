//
//  ShopsViewModel.swift
//  ColliGo
//
//  Created by Mattia Righetti on 21/04/2020.
//  Copyright © 2020 Mattia Righetti. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import MapKit

public final class ShopsViewModel: ObservableObject {
    
    private static let decoder = JSONDecoder()
    
    @Published public var fetchedOnce: Bool = false
    @Published public var fetching: Bool = false
    @Published public var shops: [Shop] = [Shop]()
    @Published public var filteredShops: [Shop] = [Shop]()
    
    private let shopsService: ShopServiceDataPublisher
    
    private var subscriptions = Set<AnyCancellable>()
    private var shopsSubscriptions = Set<AnyCancellable>()
    
    public init(shopsService: ShopServiceDataPublisher = ShopsService()) {
        self.shopsService = shopsService
        
        $shops
            .map { _ in false }
            .assign(to: \.fetching, on: self)
            .store(in: &subscriptions)
    }
    
    public func fetchShops(currLat: Double, currLng: Double) {
        self.fetching = true
        self.fetchedOnce = true
        shopsSubscriptions = []
        
        shopsService.publisher()
            .retry(1)
            .decode(type: ShopWrapper.self, decoder: Self.decoder)
            .map(\.shops)
            .handleEvents(receiveCompletion: { error in
                print(error)
            })
            .replaceError(with: [Shop.error])
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                   print("### ERROR")
                }
            }, receiveValue: { shops in
                self.shops = shops
                for index in 0..<self.shops.count {
                    self.shops[index].distance = CLLocation(latitude: self.shops[index].lat!, longitude: self.shops[index].lng!).distance(from: CLLocation(latitude: currLat, longitude: currLng)) / 1000
                }
                
                self.filteredShops = self.shops.filter({ $0.distance! < 20 })
                
                self.fetching = false
            })
            .store(in: &shopsSubscriptions)
    }
    
    public func getShops(inRange range: Double) -> [Shop] {
        return self.shops.filter({ $0.distance! < range })
    }
    
}
