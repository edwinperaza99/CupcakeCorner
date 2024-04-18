//
//  Order.swift
//  CupcakeCorner
//
//  Created by Edwin on 4/17/24.
//

import SwiftUI

@Observable
class Order: Codable {
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
    
//    address information
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var nameIsValid: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var streetAddressIsValid: Bool {
        !streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var cityIsValid: Bool {
        !city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var zipIsValid: Bool {
        let trimmedZip = zip.trimmingCharacters(in: .whitespacesAndNewlines)
        // Check if the zip is not empty and contains only numbers, 5 digits
        return !trimmedZip.isEmpty &&
               trimmedZip.allSatisfy { $0.isWholeNumber } &&
               trimmedZip.count == 5
    }
    
    var hasValidAddress: Bool {
        nameIsValid && streetAddressIsValid && cityIsValid && zipIsValid
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}
