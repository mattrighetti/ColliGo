//
//  +Double.swift
//  ColliGo
//
//  Created by Mattia Righetti on 21/04/2020.
//  Copyright © 2020 Mattia Righetti. All rights reserved.
//

import Foundation

extension Double {
    var oneDecimalPrecision : String {
        return String(format: "%.1f", self)
    }
}
