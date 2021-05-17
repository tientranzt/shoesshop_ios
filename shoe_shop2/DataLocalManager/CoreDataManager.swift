import UIKit
import CoreData

class CoreDataManager {
    static var share = CoreDataManager(moc: NSManagedObjectContext.currentContext)
    
    var moc : NSManagedObjectContext
    init(moc : NSManagedObjectContext) {
        self.moc = moc
    }
    
    func fetchTaskByColorId(colorId : String) -> Cart? {
        var task = [Cart]()
        let taskRequest :  NSFetchRequest<Cart> =  Cart.fetchRequest()
        taskRequest.predicate = NSPredicate(format: "productColorId == %@", colorId as CVarArg)
        
        do {
            task = try self.moc.fetch(taskRequest)
        } catch  {
            print(error)
        }
        return task.first ?? nil
    }
    
    //MARK: - INSERT CART ITEM
    
    func insertCart(cartModel: CartModel) -> Bool {
        if let _ = fetchTaskByColorId(colorId: cartModel.productColorId) {
            print("item exists: [\(cartModel.productColorId)]")
            //MARK: - update all properties & add on quantity += 1
            return false
        }
        let cart =  Cart(context: self.moc)
        cart.username = cartModel.username
        cart.productName = cartModel.productName
        cart.productId = cartModel.productId
        cart.productColorId = cartModel.productColorId
        cart.productSizeId = cartModel.productSizeId
        cart.productPrice = Int64(cartModel.productPrice)
        cart.productQuantity = Int64(cartModel.productQuantity)
        cart.createdAt = cartModel.createdAt
        cart.updatedAt = cartModel.updatedAt
        cart.productImage = cartModel.productImage
        cart.isSelected = cartModel.isSelected
        do {
            try self.moc.save()
            print("Insert success [\(String(describing: cart.productColorId))]")
            return true
        } catch  {
            print(error)
        }
        return false
    }
    
    //MARK: - UPDATE CART ITEM
    
    func updateCart(colorId: String, cartModel : CartModel)  {
        do {
            if let cart = fetchTaskByColorId(colorId: colorId) {
                
                cart.setValue(cart.username, forKeyPath: "username")
                cart.setValue(cart.productColorId, forKeyPath: "productColorId")
                cart.setValue(cart.productSizeId, forKeyPath: "productSizeId")
                cart.setValue(cart.productQuantity, forKeyPath: "productQuantity")
                cart.setValue(cart.productPrice, forKeyPath: "productPrice")
                cart.setValue(cart.updatedAt, forKeyPath: "updatedAt")
                
                do {
                    try self.moc.save()
                    print("Update success")
                } catch  {
                    print(error)
                }
            }
        }
    }
    
    //MARK: - DELETE CART ITEM
    
    func deleteCart(colorId: String) -> Bool {
        do {
            if let cart = fetchTaskByColorId(colorId: colorId) {
                self.moc.delete(cart)
                try self.moc.save()
                return true
            }
        } catch  {
            print(error)
        }
        return false
    }
    
    //MARK: - FETCH ALL CART ITEM
    
    func fetchAllItemCart() -> [Cart] {
        var task = [Cart]()
        let taskRequest : NSFetchRequest<Cart> = Cart.fetchRequest()
        do {
            task = try self.moc.fetch(taskRequest)
        } catch let err as NSError {
            print(err)
        }
        return task
    }
    
    func getCountItemCartSelected() -> Int {
        var count = 0
        let taskRequest :  NSFetchRequest<Cart> =  Cart.fetchRequest()
        taskRequest.predicate = NSPredicate(format: "isSelected == %i", 1)
        
        do {
            count = try self.moc.fetch(taskRequest).count
        } catch  {
            print(error)
        }
        return count
    }
    
    func getTotalPriceItemCartSelected() -> Int {
        var sum = 0
        var task = [Cart]()
        let taskRequest :  NSFetchRequest<Cart> =  Cart.fetchRequest()
        taskRequest.predicate = NSPredicate(format: "isSelected == %i", 1)
        
        do {
            task = try self.moc.fetch(taskRequest)
        } catch  {
            print(error)
        }
        for cart in task {
            sum += (Int(cart.productPrice * cart.productQuantity))
        }
        return sum
    }
    
    //MARK: - UPDATE CART ITEM
    
    func updateCart(colorId: String, isChecked : Bool) -> Bool {
        do {
            if let cart = fetchTaskByColorId(colorId: colorId) {
                cart.isSelected = isChecked
                do {
                    try self.moc.save()
                    return true
                } catch  {
                    print(error)
                }
            }
        }
        return false
    }
    
    func updateCart(colorId: String, quantity : Int) -> Bool  {
        do {
            if let cart = fetchTaskByColorId(colorId: colorId) {
                cart.productQuantity = Int64(quantity)
                do {
                    try self.moc.save()
                    return true
                } catch  {
                    print(error)
                }
            }
        }
        return false
    }
}
