//
//  CoffeeModel.swift
//  CofeeOrderShop
//
//  Created by Moin on 4/25/25.
//

import Foundation

@MainActor
class CoffeeModel: ObservableObject {
    let webService: WebService
    @Published private(set) var orders: [Order] = []
    
    init(webService: WebService, orders: [Order]) {
        self.webService = webService
    }
    
    func populateData() async throws {
        orders = try await webService.getOrders()
    }
    
    
}




