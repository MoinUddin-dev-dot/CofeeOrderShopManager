//
//  CofeeOrderShopApp.swift
//  CofeeOrderShop
//
//  Created by Moin on 4/24/25.
//

import SwiftUI

@main
struct CofeeOrderShopApp: App {
    
    @StateObject private var model : CoffeeModel
    
    init() {
        let webService = WebService()
        _model = StateObject(wrappedValue: CoffeeModel(webService: webService))
    }
    
    var body: some Scene {
        
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
