//
//  String+Extensions.swift
//  CofeeOrderShop
//
//  Created by Moin on 4/30/25.
//

import Foundation

extension String {
    
    func isNumeric() -> Bool {
        Double(self) != nil
    }
    
    var isNotEmpty: Bool {
        !self.isEmpty
    }
    
    func isLessThan(number: Double) -> Bool {
        if !self.isNumeric() {
            return false
        }
        
        guard let value = Double(self) else {
            return false
        }
        
        return value <  number
    }
}
