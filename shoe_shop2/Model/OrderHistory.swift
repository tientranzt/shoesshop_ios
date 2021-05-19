//
//  Model.swift
//  shoe_shop2
//
//  Created by Nhat on 5/19/21.
//

import Foundation

struct OrderHistory: Codable { 
    
    var dateOrder: String
    var shipAddress: String
    var totalItem: Int
    var totalPrice: Double
    
}
