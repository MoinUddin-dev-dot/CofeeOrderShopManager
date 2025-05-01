//
//  Order.swift
//  CofeeOrderShop
//
//  Created by Moin on 4/24/25.
//

import Foundation

enum CoffeeOrderError: Error {
    case invalidOrderID
}

enum CofeeSize: String, CaseIterable, Codable {
    case small =  "Small"
    case medium = "Medium"
    case large = "Large"
}

struct Order: Codable, Identifiable, Hashable {
    
    var id: Int?
    var name: String
    var coffeeName: String
    var total : Double
    var size: CofeeSize
    
}
