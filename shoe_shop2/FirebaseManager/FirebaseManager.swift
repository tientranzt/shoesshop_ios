//import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import CodableFirebase
import FacebookCore
import FacebookLogin

class FirebaseManager {
    
    static let shared = FirebaseManager()
    let ref = Database.database().reference()
    
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
            self.ref.child("UserProfile").child(currentUser.uid).child("userName").setValue(userName)
            self.ref.child("UserProfile").child(currentUser.uid).child("email").setValue(Email)
            self.ref.child("UserProfile").child(currentUser.uid).child("userId").setValue(currentUser.uid)
            self.ref.child("UserProfile").child(currentUser.uid).child("shipAddress").setValue("")
            self.ref.child("UserProfile").child(currentUser.uid).child("phoneNumber").setValue("")
            self.ref.child("UserProfile").child(currentUser.uid).child("imgAvatar").setValue("")
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
            self.ref.child("UserProfile").child(currentUser.uid).getData { (error, snapshot) in
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
    
    
    func updateUser(user: User){
        if isSignIn() {
            let currentUser = user.userId
            self.ref.child("UserProfile").child(currentUser).child("userName").setValue(user.userName)
            self.ref.child("UserProfile").child(currentUser).child("email").setValue(user.email)
            self.ref.child("UserProfile").child(currentUser).child("userId").setValue(currentUser)
            self.ref.child("UserProfile").child(currentUser).child("shipAddress").setValue(user.shipAddress)
            self.ref.child("UserProfile").child(currentUser).child("phoneNumber").setValue(user.phoneNumber)
            self.ref.child("UserProfile").child(currentUser).child("imgAvatar").setValue(user.imgAvatar)
            self.ref.child("UserProfile").child(currentUser).child("isNewUser").setValue("FALSE")
            
        }
    }
    
    // MARK: - order History
    
    func fetchOrderHistory(completion : @escaping (DataSnapshot) -> Void) {
        
        let userId = getUserId()
        if userId != "" {
            self.ref.child("UserProfile").child(userId).getData { (error, snapshot) in
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
    
    func parseNotificationModel(key : String ,object : AnyObject) -> NotificationModel {
    
        let title =  object["title"] as! String
        let body =  object["body"] as! String
        let color =  object["color"] as! String
        let notificationModel =  NotificationModel(keyPath: key, color: color, title: title, body: body)
        print(notificationModel)
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
    
    func parseUser(object: AnyObject) -> User {
        
        let userName = object["userName"] as! String
        let email = object["email"] as! String
        let shipAddress = object["shipAddress"] as! String
        let phoneNumber = object["phoneNumber"] as! String
        let imgAvatar = object["imgAvatar"] as! String
        let isNewUser = object["isNewUser"] as! String
        
        return User(userId: self.getUserId(), userName: userName, email: email, shipAddress: shipAddress, phoneNumber: phoneNumber, imgAvatar: imgAvatar, isNewUser: isNewUser)
        
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
            guard let realResult = result else {
                return
            }
            self?.ref.child("UserProfile").child(realResult.user.uid).child("isNewUser").setValue("TRUE")
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
    // completion Result
    func login(credential: AuthCredential, completion: @escaping (Result<Bool,Error>) -> () ) {
        FirebaseAuth.Auth.auth().signIn(with: credential) { [weak self] (result, error) in
            guard let _ = self else {
                return
            }
            
            if let realError = error {
                completion(.failure(realError))
                return
            }
            if  self?.getUserId() != "" {
                
                guard let user = Auth.auth().currentUser else {
                    return
                }
                
                self?.ref.child("UserProfile/\(user.uid)").observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.exists() {
                        //User is signing IN
                        self?.ref.child("UserProfile").child(self?.getUserId() ?? "").child("isNewUser").setValue("FALSE")
                    } else {
                        let email = user.email ?? ""
                        let userName = user.displayName ?? ""
                        self?.insertUser(userName: userName, Email: email)
                        self?.ref.child("UserProfile").child(self?.getUserId() ?? "").child("isNewUser").setValue("TRUE")
                    }
                    completion(.success(true))
                })
            }
        }
    }
    
    func signInWithEmail(email: String,password: String, completion: @escaping (Result<Bool,Error>) -> ()) {
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) {   [weak self] (result, error) in
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
                    completion(reviewList)
                }
            }
            else {
                print("No data available")
                completion(reviewList)
            }
        }
    }
    
    
    func signOut() -> Bool {
        if isSignIn() {
            do {
                try Auth.auth().signOut()
                LoginManager().logOut()
                // need with apole
            } catch  {
                return false
            }
        }
        return true
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
    
}
