//
//  Order.swift
//  CupcakeCorner
//
//  Created by Akash Sheelavant on 7/28/24.
//

import SwiftUI

@Observable
class Order: Codable {
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
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
        if name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty ||
            streetAddress.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty ||
            city.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty ||
            zip.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2
        
        // complicated cakes cost more
        cost += Decimal(type)/2
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        return cost
    }
}
