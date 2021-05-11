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
        taskRequest.predicate = NSPredicate(format: "shoe_color_id == %@", colorId as CVarArg)
        
        do {
            task = try self.moc.fetch(taskRequest)
        } catch  {
            print(error)
        }
        return task.first!
    }
    
    //MARK: - INSERT CART ITEM

    func insertCart(cartModel: CartModel) {
        let cart =  Cart(context: self.moc)
        cart.setValue(cart.username, forKeyPath: "username")
        cart.setValue(cart.shoe_id, forKeyPath: "shoe_id")
        cart.setValue(cart.shoe_color_id, forKeyPath: "shoe_color_id")
        cart.setValue(cart.shoe_size_id, forKeyPath: "shoe_size_id")
        cart.setValue(cart.quantity, forKeyPath: "quantity")
        cart.setValue(cart.price, forKeyPath: "price")
        cart.setValue(cart.created_at, forKeyPath: "created_at")

        do {
            try self.moc.save()
            print("Insert success")
        } catch  {
            print(error)
        }
    }

    //MARK: - UPDATE CART ITEM
    
    func updateCart(colorId: String, cartModel : CartModel)  {
        do {
            if let cart = fetchTaskByColorId(colorId: colorId) {
                
                cart.setValue(cart.username, forKeyPath: "username")
                cart.setValue(cart.shoe_id, forKeyPath: "shoe_id")
                cart.setValue(cart.shoe_color_id, forKeyPath: "shoe_color_id")
                cart.setValue(cart.shoe_size_id, forKeyPath: "shoe_size_id")
                cart.setValue(cart.quantity, forKeyPath: "quantity")
                cart.setValue(cart.price, forKeyPath: "price")
                cart.setValue(cart.updated_at, forKeyPath: "updated_at")
                
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
    
    func deleteCart(colorId: String) {
        do {
            if let cart = fetchTaskByColorId(colorId: colorId) {
                self.moc.delete(cart)
                try self.moc.save()
                print("Delete success")
            }
        } catch  {
            print(error)
        }
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
    
}
