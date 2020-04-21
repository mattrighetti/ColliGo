//
//  ShopsDataPublisher.swift
//  ColliGo
//
//  Created by Mattia Righetti on 21/04/2020.
//  Copyright © 2020 Mattia Righetti. All rights reserved.
//

import Foundation
import Combine

public protocol ShopServiceDataPublisher {
    func publisher() -> AnyPublisher<Data, URLError>
}
