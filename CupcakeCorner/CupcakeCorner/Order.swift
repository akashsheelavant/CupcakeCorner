//
//  Order.swift
//  CupcakeCorner
//
//  Created by Akash Sheelavant on 7/28/24.
//

import SwiftUI

@Observable
class Order {
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
}
