//
//  ContentView.swift
//  CofeeOrderShop
//
//  Created by Moin on 4/24/25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var model : CoffeeModel
    func populateOrders() async {
        do{
            try await model.populateData()
        } catch{
            print(error)
        }
    }
    
    var body: some View {
        VStack {
            List(model.orders) { order in
                OrderCellView(order: order)
            }
            .task {
                await populateOrders()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environmentObject(CoffeeModel(webService: WebService()))
}


