//
//  AddCoffeeView.swift
//  CofeeOrderShop
//
//  Created by Moin on 4/30/25.
//

import SwiftUI

struct AddCoffeeError{
    var name: String = ""
    var coffeeName:String = ""
    var price:String = ""
}

struct AddCoffeeView: View {
    

    @EnvironmentObject private var model : CoffeeModel
    @State private var name: String = ""
    @State private var coffeeName: String = ""
    @State private var price: String = ""
    @State private var coffeeSize: CofeeSize = .medium
    @State private var errors: AddCoffeeError = AddCoffeeError()
    @Environment(\.dismiss) private var dismiss
    
    var isValid: Bool {
        errors = AddCoffeeError()
        if name.isEmpty {
            errors.name = "Name cannot be empty"
        }
        
        if coffeeName.isEmpty {
            errors.coffeeName = "Coffee Name cannot be empty"
        }
        
        if price.isEmpty {
            errors.price = "Price cannot be empty"
        }else if !price.isNumeric() {
            errors.price = "price needs to be a number"
        }else if price.isLessThan(number: 1){
            errors.price = "price cant be less than 1"
        }
        
        return errors.name.isEmpty && errors.coffeeName.isEmpty && errors.price.isEmpty
    }
    
    func placeOrder() async {
        let order = Order(name: name, coffeeName: coffeeName, total: Double(price) ?? 0 , size: coffeeSize)
        do{
            try await model.placeOrder(order)
            
            dismiss()
        }
        catch{
            print(error)
        }
    }
    
    var body: some View {
        NavigationStack{
            
            Form{
                
                TextField("Name", text: $name)
                    .accessibilityIdentifier("name")
                Text(errors.name).visible(errors.name.isNotEmpty)
                TextField("Coffee Name", text: $coffeeName)
                    .accessibilityIdentifier("coffeeName")
                Text(errors.coffeeName).visible(errors.coffeeName.isNotEmpty)
                    .font(.caption)
                TextField("Price", text: $price)
                    .accessibilityIdentifier("price")
                Text(errors.price).visible(!errors.price.isEmpty)
                    .font(.caption)
                Picker("Select size", selection: $coffeeSize) {
                    ForEach(CofeeSize.allCases, id: \.rawValue) { size in
                        Text(size.rawValue).tag(size)
                    }
                }
                .pickerStyle(.segmented)
                
                Button("Place Order") {
                   
                    if isValid {
                        Task{
                            await placeOrder()
                        }
                    }
                    
                }.accessibilityIdentifier("placeOrderButton")
                    .centerHorizontally()
                   
            }
            .navigationTitle("Add Order")
        }
    }
}

#Preview {
    AddCoffeeView()
}
