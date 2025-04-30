//
//  View+Extension.swift
//  CofeeOrderShop
//
//  Created by Moin on 4/30/25.
//

import Foundation
import SwiftUI

extension View {
    func centerHorizontally() -> some View {
        HStack{
            Spacer()
            self
            Spacer()
        }
    }
    
    @ViewBuilder
    func visible(_ condition: Bool) -> some View {
        switch condition{
        case true :
            self
        case false:
            EmptyView()
        }
    }
}
