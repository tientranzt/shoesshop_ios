import Foundation
import UIKit

struct CartModel  {
    
    var username: String
    var productName: String
    var productId: String
    var productColorId: String
    var productSizeId: String
    var productQuantity: Int
    var productPrice: Int
    var productImage: String
    var createdAt: String
    var updatedAt: String?
    var isSelected: Bool
    
    
    init(username: String, productName: String, productId: String, productColorId: String, productSizeId: String, productQuantity: Int, productPrice: Int, productImage: String, createdAt: String) {
        self.username = username
        self.productName = productName
        self.productId = productId
        self.productColorId = productColorId
        self.productSizeId = productSizeId
        self.productQuantity = productQuantity
        self.productPrice = productPrice
        self.productImage = productImage
        self.createdAt = createdAt
        self.updatedAt = nil
        self.isSelected = true
    }
    
    mutating func changeQuantity(username: String, productColorId: String, productQuantity: Int, updatedAt: String) {
        self.username = username
        self.productColorId = productColorId
        self.productQuantity = productQuantity
        self.updatedAt = updatedAt
    }
}
