//
//  Shop.swift
//  ColliGo
//
//  Created by Mattia Righetti on 21/04/2020.
//  Copyright © 2020 Mattia Righetti. All rights reserved.
//

import Foundation
import MapKit

struct ShopWrapper: Codable {
    public let lat: Int?
    public let lng: Int?
    public let shops: [Shop]
}

public struct Shop: Identifiable, Codable, Equatable {
    
    static let error = Shop(
        id: -1,
        natural_key: "error",
        name: "Error",
        address: "",
        city: "",
        cap: "",
        lat: 0,
        lng: 0,
        phone: "",
        whatsapp: "",
        website: "",
        telegram: "",
        facebook: "",
        description: "",
        is_deleted: true,
        accept_terms_and_conditions: false,
        messenger: "",
        created_at: "",
        updated_at: "",
        categories: []
    )
    
    public let id: Int
    public let natural_key: String?
    public let name: String
    public let address: String?
    public let city: String?
    public let cap: String?
    public let lat: Double?
    public let lng: Double?
    public let phone: String?
    public let whatsapp: String?
    public let website: String?
    public let telegram: String?
    public let facebook: String?
    public let description: String?
    public let is_deleted: Bool?
    public let accept_terms_and_conditions: Bool?
    public let messenger: String?
    public let created_at: String?
    public let updated_at: String?
    public let categories: [Category]
    public var distance: Double?
    
    public static func == (lhs: Shop, rhs: Shop) -> Bool {
        return lhs.id == rhs.id
    }
}

public struct Category: Identifiable, Codable, Equatable {
    public let id: Int
    public let natural_key: String?
    public let name: String?
}
