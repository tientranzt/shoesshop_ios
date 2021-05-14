//import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class FirebaseManager {
    
    static let shared = FirebaseManager()
    private var ref = Database.database().reference()
    
    func fetchProductCategory(completion : @escaping (DataSnapshot) -> Void) {
        ref.child("Category").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                completion(snapshot)
            }
            else {
                print("No data available")
            }
        }
    }
    
    func fetchProduct(completion : @escaping (DataSnapshot) -> Void) {
        ref.child("CategoryProduct/adidas").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                completion(snapshot)
            }
            else {
                print("No data available")
            }
        }
    }
    
    func fectProductColor(idPath: String? , completion : @escaping (DataSnapshot) -> Void ) {
        if let id = idPath {
            ref.child("ProductColor/\(id)").getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                }
                else if snapshot.exists() {
                    completion(snapshot)
                }
                else {
                    print("No data available")
                }
            }
        }
    }
    

    // MARK: - Parse Model
    func parseCategorModel(id: String, object : AnyObject) -> CategoryModel {
        let categoryName = object["name"] as! String
        let country = object["country"] as! String
        return CategoryModel(id: id , name: categoryName, country: country)
    }
    
    func parseProductModel(id: String, object : AnyObject) -> ProductModel {
       
        let obj = object as! [String: AnyObject]
        let productName = obj["product_name"] as! String
        let presentProduct = obj["present"] as! [String: AnyObject]

        let colorCode = presentProduct["color_code"] as! String
        let idColor = presentProduct["id_color"] as! String
        let image = presentProduct["image"] as! String
        let price = presentProduct["price"] as! String

        let productModel = ProductModel(id: id, productName: productName, colorCode: colorCode, idColor: idColor, image: image, price: price)
        return productModel
        
    }
    
    func parseProductColorModel(idProductCategory : String,id : String, object : AnyObject) -> ProductColor {

        let obj = object as! [String: AnyObject]
        let colorCode = obj["color_code"] as! String
        let description = obj["description"] as! String
        let image = obj["image"] as! String
        let price = obj["price"] as! String
        let size = obj["size"] as! [String: Int]
//        let pr = ProductColor(id: id, productCategoryId: idProductCategory, colorCode: colorCode, description: description, imageLink: image, price: price, size: size)

        return ProductColor(id: id, productCategoryId: idProductCategory, colorCode: colorCode, description: description, imageLink: image, price: price, size: size)
    }
    
    
    
    
}

