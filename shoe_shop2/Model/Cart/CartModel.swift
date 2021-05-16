import Foundation
import UIKit

struct CartModel  {
    
    var username: String
    var shoeName: String
    var shoeId: String
    var shoeColorId: String
    var shoeSizeId: String
    var shoeQuantity: Int
    var shoePrice: Int
    var shoeImage: String
    var createdAt: String
    var updatedAt: String?
    var isSelected: Bool
    
    
    init(username: String, shoeName: String, shoeId: String, shoeColorId: String, shoeSizeId: String, shoeQuantity: Int, shoePrice: Int, shoeImage: String, createdAt: String) {
        self.username = username
        self.shoeName = shoeName
        self.shoeId = shoeId
        self.shoeColorId = shoeColorId
        self.shoeSizeId = shoeSizeId
        self.shoeQuantity = shoeQuantity
        self.shoePrice = shoePrice
        self.shoeImage = shoeImage
        self.createdAt = createdAt
        self.updatedAt = nil
        self.isSelected = true
    }
    
    mutating func changeQuantity(username: String, shoeColorId: String, shoeQuantity: Int, updatedAt: String) {
        self.username = username
        self.shoeColorId = shoeColorId
        self.shoeQuantity = shoeQuantity
        self.updatedAt = updatedAt
    }
}
