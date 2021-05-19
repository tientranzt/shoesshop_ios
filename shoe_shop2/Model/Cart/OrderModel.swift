import Foundation
import UIKit

struct OrderModel: Codable  {
    var productId: String
    var productColorId: String
    var productSizeId: String
    var productQuantity: Int
    var productPrice: Int
    var createdAt: String
    var updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case productColorId = "product_color_id"
        case productSizeId = "product_size_id"
        case productQuantity = "product_quantity"
        case productPrice = "product_price"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(model: CartModel) {
        self.productId = model.productId
        self.productColorId = model.productColorId
        self.productSizeId = model.productSizeId
        self.productQuantity = model.productQuantity
        self.productPrice = model.productPrice
        self.createdAt = model.createdAt
        self.updatedAt = model.updatedAt
    }
}
