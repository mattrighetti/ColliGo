//
//  ShopsService.swift
//  ColliGo
//
//  Created by Mattia Righetti on 21/04/2020.
//  Copyright © 2020 Mattia Righetti. All rights reserved.
//

import Foundation
import Combine

public struct ShopsService {
    
    private var url: URL {
        urlComponents.url!
    }
    
    private var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.colligo.shop"
        components.path = "/shops"
        return components
    }
    
    public init() { }
}

extension ShopsService: ShopServiceDataPublisher {
    public func publisher() -> AnyPublisher<Data, URLError> {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .print()
            .eraseToAnyPublisher()
    }
}
