//import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import CodableFirebase

class FirebaseManager {
    
    static let shared = FirebaseManager()
    var ref = Database.database().reference()
    
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
    
    func fetchProduct(categoryId: String, completion : @escaping (DataSnapshot) -> Void) {
        ref.child("CategoryProduct/\(categoryId)").getData { (error, snapshot) in
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
    
    func fetchProductLastest(completion : @escaping (DataSnapshot) -> Void) {
        ref.child("CategoryProduct/nike").getData { (error, snapshot) in
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
    
    func fetchNotifications(completion : @escaping (DataSnapshot) -> Void) {
        ref.child("Notifications").getData { (error, snapshot) in
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
    
    
    // MARK: - User firebase
    
    func insertUser(userName: String, Email: String) {
        if let currentUser = Auth.auth().currentUser {
            self.ref.child("UserProfile").child(currentUser.uid).child("Username").setValue(userName)
            self.ref.child("UserProfile").child(currentUser.uid).child("Email").setValue(Email)
        }
       
    }
    
    func getUserId() -> String {
        if let user = Auth.auth().currentUser {
            return user.uid
        }
        return ""
    }
    
    func fetchUser(completion: @escaping (DataSnapshot) -> Void) {
        
        if let currentUser = Auth.auth().currentUser {
            self.ref.child("UserProfile/\(currentUser.uid)").getData { (error, snapshot) in
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
    
    func sendEmailResetPassword(email: String, completion: @escaping (Result<Bool,Error>) -> () ) {
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let realError = error {
                completion(.failure(realError))
            }
            // send succes
            completion(.success(true))
            
        }
    }

    // MARK: - Parse Model
    
    func parseNotificationModel(object : AnyObject) -> NotificationModel {
    
        let title =  object["title"] as! String
        let body =  object["body"] as! String
        let color =  object["color"] as! String
        let notificationModel =  NotificationModel(color: color, title: title, body: body)
    
        return notificationModel
    }
    
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
    
    func parseUser() {
        
    }
    
    // MARK: - Auth Firebase
    // sign up with fire base by email/password
    func signUpWithEmail(email: String,password: String, completion: @escaping (Result<Bool,Error>) -> ()) {
        
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            guard let _ = self else {
                return
            }
            
            if let realError = error {
                completion(.failure(realError))
                return
            }
            // sign up success
            
            completion(.success(true))
        }
    }
    
    // return if login
    func isSignIn() -> Bool {
        
        if let _ = FirebaseAuth.Auth.auth().currentUser {
            
            return true
        }
        
        return false
    }
    
    // login with firebase by facebook or apple
    
    func login(credential: AuthCredential, completion: @escaping (Result<Bool,Error>) -> () ) {
        FirebaseAuth.Auth.auth().signIn(with: credential) { [weak self] (result, error) in
            guard let _ = self else {
                return
            }
            
            if let realError = error {
                completion(.failure(realError))
                return
            }
            
            completion(.success(true))
        }
    }
    
    // nho load data user khi dang nhap thanh cong
    func signInWithEmail(email: String,password: String, completion: @escaping (Result<Bool,Error>) -> ()) {
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) {   [weak self] (result, error) in
            guard let _ = self else {
                return
            }
            
            if let realError = error {
                completion(.failure(realError))
                return
            }
            // sign up success
            completion(.success(true))
        }
    }
    
    
    // MARK: - fetch review data
//    completion : @escaping ([Review]) -> Void
    func fetchReviewData(reviewId : String, completion : @escaping ([Review]) -> Void) {
        
        var reviewList : [Review] = []
        
        self.ref.child("reviews/\(reviewId)").observe(.value) { (snapshot) in
            if snapshot.exists() {
                let value = snapshot.value as! [String : AnyObject]
                
                do {
                    reviewList = []
                    for review in value{
                        let rev  = try FirebaseDecoder().decode(Review.self, from: review.value)
                        reviewList.append(rev)
                    }
                    
                    completion(reviewList)
                    
                    
                } catch let error {
                    print(error)
                }
            }
            else {
                print("No data available")
            }
        }
    }
    
}
