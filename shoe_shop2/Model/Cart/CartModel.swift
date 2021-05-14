import Foundation
import UIKit

struct CartModel  {
    
    var username: String
    var shoeName: String
    var shoeColorId: String
    var shoeSizeId: String
    var shoeQuantity: Int
    var shoePrice: Int
    var shoeImage: String
    var createdAt: String
    var updatedAt: String?
    var isSelected: Bool
    
    
    init(username: String, shoeName: String, shoeColorId: String, shoeSizeId: String, shoeQuantity: Int, shoePrice: Int, shoeImage: String, createdAt: String) {
        self.username = username
        self.shoeName = shoeName
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
    //MARK:- DELETE AFTER MERGE
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    static func setDataTemp() {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        let nameImage = "shoe2"
        if let image = UIImage(named: "shoe2") {
            if let data = image.jpegData(compressionQuality: 0.8) {
                let filename = getDocumentsDirectory().appendingPathComponent(nameImage)
                try? data.write(to: filename)
                    print(filename)
                
            }
        }
//        let dataImage = image?.pngData()
//        let dataImage = image?.jpegData(compressionQuality: 0.9)
        var tmp = false
        tmp = CoreDataManager.share.insertCart(cartModel: CartModel(username: "lxt", shoeName: "Nike 001", shoeColorId: "nike-001-red", shoeSizeId: "nike001-red-41", shoeQuantity: 2, shoePrice: 450, shoeImage: nameImage, createdAt: formatter.string(from: now)))
        tmp = CoreDataManager.share.insertCart(cartModel: CartModel(username: "lxt", shoeName: "Nike 002", shoeColorId: "nike-002-red", shoeSizeId: "nike002-red-41", shoeQuantity: 3, shoePrice: 550, shoeImage: nameImage, createdAt: formatter.string(from: now)))
        tmp = CoreDataManager.share.insertCart(cartModel: CartModel(username: "lxt", shoeName: "Nike 003", shoeColorId: "nike-003-red", shoeSizeId: "nike003-red-41", shoeQuantity: 5, shoePrice: 350, shoeImage: nameImage, createdAt: formatter.string(from: now)))
        tmp = CoreDataManager.share.insertCart(cartModel: CartModel(username: "lxt", shoeName: "Nike 004", shoeColorId: "nike-004-red", shoeSizeId: "nike004-red-41", shoeQuantity: 1, shoePrice: 600, shoeImage: nameImage, createdAt: formatter.string(from: now)))
        tmp = CoreDataManager.share.insertCart(cartModel: CartModel(username: "lxt", shoeName: "Nike 005", shoeColorId: "nike-005-red", shoeSizeId: "nike005-red-41", shoeQuantity: 55, shoePrice: 440, shoeImage: nameImage, createdAt: formatter.string(from: now)))
        tmp = CoreDataManager.share.insertCart(cartModel: CartModel(username: "lxt", shoeName: "Nike 006", shoeColorId: "nike-006-red", shoeSizeId: "nike006-red-41", shoeQuantity: 55, shoePrice: 450, shoeImage: nameImage, createdAt: formatter.string(from: now)))
        tmp = CoreDataManager.share.insertCart(cartModel: CartModel(username: "lxt", shoeName: "Nike 007", shoeColorId: "nike-007-red", shoeSizeId: "nike007-red-41", shoeQuantity: 55, shoePrice: 340, shoeImage: nameImage, createdAt: formatter.string(from: now)))
        tmp = CoreDataManager.share.insertCart(cartModel: CartModel(username: "lxt", shoeName: "Nike 008", shoeColorId: "nike-008-red", shoeSizeId: "nike008-red-41", shoeQuantity: 55, shoePrice: 240, shoeImage: nameImage, createdAt: formatter.string(from: now)))
        tmp = CoreDataManager.share.insertCart(cartModel: CartModel(username: "lxt", shoeName: "Nike 009", shoeColorId: "nike-009-red", shoeSizeId: "nike009-red-41", shoeQuantity: 5, shoePrice: 450, shoeImage: nameImage, createdAt: formatter.string(from: now)))
        tmp = CoreDataManager.share.insertCart(cartModel: CartModel(username: "lxt", shoeName: "Nike 010", shoeColorId: "nike-010-red", shoeSizeId: "nike010-red-41", shoeQuantity: 5, shoePrice: 550, shoeImage: nameImage, createdAt: formatter.string(from: now)))
    }
    //MARK:- END
}
