//
//  OrderDetailView.swift
//  CofeeOrderShop
//
//  Created by Moin on 5/1/25.
//

import SwiftUI

struct OrderDetailView: View {
    
    let orderId: Int
    @EnvironmentObject private var model: CoffeeModel
    @State private var isPresented: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    private func deleteOrder() async {
        do{
            try await model.deleteOrder(orderId)
            dismiss()
        }catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack{
            if let order = model.orderById(id: orderId) {
                VStack(alignment: .leading, spacing: 10){
                    Text(order.coffeeName)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityIdentifier("coffeeNameText")
                    Text(order.size.rawValue)
                        .opacity(0.5)
                    Text( order.total as NSNumber, formatter: NumberFormatter.currency)
                    HStack{
                        Spacer()
                        Button("Delete Order", role: .destructive) {
                            Task{
                                await deleteOrder()
                            }
                        }
                        Button("Edit Order", role: .cancel) {
                            isPresented = true
                        }.accessibilityIdentifier("editOrderButton")
                        Spacer()
                    }
                }
                .sheet(isPresented: $isPresented) {
                    AddCoffeeView(order: order)
                }
            }
            Spacer()
            
            
        }.padding()
    }
}

#Preview {
    var config = Configuration()
    OrderDetailView(orderId: 1).environmentObject(CoffeeModel(webService: WebService(baseURL: config.environment.baseURL)))

}
