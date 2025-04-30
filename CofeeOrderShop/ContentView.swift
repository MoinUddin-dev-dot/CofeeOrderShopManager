//
//  ContentView.swift
//  CofeeOrderShop
//
//  Created by Moin on 4/24/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented = false
    @EnvironmentObject private var model : CoffeeModel
    func populateOrders() async {
        do{
            try await model.populateData()
        } catch{
            print(error)
        }
    }
    
    func deleteOrder(_ indexSet: IndexSet)  {
        indexSet.forEach { index in
            let order = model.orders[index]
            guard let orderId = order.id else {
                return
            }
            Task{
                do{
                    try await model.deleteOrder(orderId)
                }catch{
                    print(error)
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                if(model.orders.isEmpty){
                    Text("No Orders Available").accessibilityIdentifier("noOrdersText")
                } else {
                    List{
                        ForEach(model.orders) { order in
                            OrderCellView(order: order)
                        }
                        .onDelete(perform: deleteOrder)
                    }
                }
            }
            .task {
                await populateOrders()
            }
            .sheet(isPresented: $isPresented, content: {
                
                AddCoffeeView()
            })
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add New Order"){
                        isPresented = true
                    }.accessibilityIdentifier("addNewOrderButton")
                }
            }
            .navigationTitle("Coffee Order Shop")
            
        }
        
    }
}

#Preview {
    var config = Configuration()
    ContentView()
        .environmentObject(CoffeeModel(webService: WebService(baseURL: config.environment.baseURL)))
}


