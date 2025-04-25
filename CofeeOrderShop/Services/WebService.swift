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
    
    func getOrders() async throws -> [Order] {
        //https://island-bramble.glitch.me/test/orders
        guard let url = URL(string: "https://island-bramble.glitch.me/test/orders") else {
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
