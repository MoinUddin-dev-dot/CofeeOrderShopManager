//
//  NumberFormatter+Extensions.swift
//  CofeeOrderShop
//
//  Created by Moin on 4/27/25.
//

import Foundation

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
