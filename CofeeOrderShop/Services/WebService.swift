//
//  WebService.swift
//  CofeeOrderShop
//
//  Created by Moin on 4/24/25.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badRequest
    case decodingError
}

class WebService {
    
    private let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func updateorder(_ order: Order) async throws -> Order {
        guard let orderId = order.id else {
            throw NetworkError.badRequest
        }
         
        guard let url = URL(string: Enviroment.updateOrder(orderId).path  , relativeTo: baseURL) else {
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(order)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        guard let updatedOrder = try? JSONDecoder().decode(Order.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return updatedOrder
    }
    
    func deleteOrder(orderId: Int) async throws -> Order {
        guard let url = URL(string: Enviroment.deleteOrder(orderId).path, relativeTo: baseURL) else {
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        guard let deletedOrder = try? JSONDecoder().decode(Order.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return deletedOrder
    }
    
    func placeOrder(order: Order) async throws -> Order {
        guard let url = URL(string: Enviroment.placeOrder.path, relativeTo: baseURL) else {
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(order)
        
        let (data,response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        guard let newOrder = try? JSONDecoder().decode(Order.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return newOrder
    }
    
    func getOrders() async throws -> [Order] {
        //https://island-bramble.glitch.me/test/orders
        guard let url = URL(string: Enviroment.allOrders.path, relativeTo: baseURL) else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        guard let orders = try? JSONDecoder().decode([Order].self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return orders
    }
}
