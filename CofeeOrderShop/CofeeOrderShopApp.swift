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
        var config = Configuration()
        let webService = WebService(baseURL: config.environment.baseURL)
        _model = StateObject(wrappedValue: CoffeeModel(webService: webService))
    }
    
    var body: some Scene {
        
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
