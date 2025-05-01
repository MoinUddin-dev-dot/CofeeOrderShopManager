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
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func orderById(id: Int) -> Order? {
        guard let index = orders.firstIndex(where: { $0.id == id }) else {
            return nil
        }
        return orders[index]
    }
    
    func populateData() async throws {
        orders = try await webService.getOrders()
    }
    
    func placeOrder(_ order: Order) async throws {
        
        let newOrder = try await webService.placeOrder(order: order)
        orders.append(newOrder)
    }
    
    func deleteOrder(_ orderId: Int) async throws{
        let deleteOrder = try await webService.deleteOrder(orderId: orderId)
        orders = orders.filter { $0.id != deleteOrder.id }
    }
    
    func updateOrder(_ order: Order) async throws {
        let updatedOrder = try await webService.updateorder(order)
        guard let index = orders.firstIndex(where: {$0.id  == order.id}) else {
            throw CoffeeOrderError.invalidOrderID
        }
        orders[index] = updatedOrder
    }
    
}




