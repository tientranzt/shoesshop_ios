//
//  CheckoutViewController.swift
//  shoe_shop2
//
//  Created by Nguyen Thanh Phuc on 5/7/21.
//

import UIKit
import RAMAnimatedTabBarController

class CheckoutViewController: UIViewController {
    
    //MARK: - Properties + Outlet
    let indicator = UIActivityIndicatorView()
    var cartListInput: [Cart] = []
    var dataInput: [String : Any] = [:]
    @IBOutlet weak var viewShipAddress: UIView!
    @IBOutlet weak var txtAddress: UILabel!
    @IBOutlet weak var viewPaymentMethod: UIView!
    @IBOutlet weak var btnOrder: UIButton!
    @IBOutlet weak var lblTotalItem: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    
    @IBOutlet weak var viewPayCrash: PaymentCashMethod!
    @IBOutlet weak var viewPayVisa: PaymentOnlineMethod!
    
    @IBOutlet weak var viewPayPaypal: PaymentOnlineMethod!
    var currentUser: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        txtAddress.adjustsFontSizeToFitWidth = true
        
        viewPayVisa.seriMethod.text = "•••• •••• ••••"
        viewPayVisa.methodName.text = "Visa"
        
        viewPayPaypal.seriMethod.text = "•••• •••• ••••"
        viewPayPaypal.methodName.text = "Paypal"
        viewPayPaypal.imageMethod.image = UIImage(named: "paypal")
        
    }
    
    override func viewDidLayoutSubviews() {
        
        // shadown
        // chay sai khi chay iphone 8 , nen cho vao viewDidLayoutSubbiew
        setShadowForView(view: viewShipAddress)
        setShadowForView(view: viewPaymentMethod)
        btnOrder.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let saveUser = UserDefaults.standard.object(forKey: "user") as? Data {
            let decoder = JSONDecoder()
            if let loadUser = try? decoder.decode(User.self, from: saveUser) {
                txtAddress.text = "Phone Number: " + loadUser.phoneNumber + "\n Address: " + loadUser.shipAddress
                self.currentUser = loadUser
            }
        }
        else {
            // fetch data user from firebase
            FirebaseManager.shared.fetchUser { [weak self] (dataSnapshot) in
                let data = dataSnapshot.value as AnyObject
                self?.currentUser = FirebaseManager.shared.parseUser(object: data)
                if let realUser = self?.currentUser {
                    DispatchQueue.main.async {
                        self?.txtAddress.text = "Phone Number: " + realUser.phoneNumber + "\n Address: " + realUser.shipAddress
                    }
                    // save to user default
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(realUser) {
                        let defaults = UserDefaults.standard
                        defaults.set(encoded, forKey: "user")
                    }
                }
            }
            
        }
    }
    
    func setData() {
        if let totalItem = dataInput["totalItem"], let totalPrice = dataInput["totalPrice"] {
            lblTotalItem.text = "\(totalItem) item"
            lblTotalPrice.text = "\(totalPrice) $"
        }
    }
    
    func setShadowForView(view: UIView) {
        
        view.layer.borderColor = UIColor(named: "grayMainBackground")?.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        
        view.layer.shadowColor = UIColor(red: 197/255, green: 197/255, blue: 197/255, alpha: 1).cgColor
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.2
        
    }
    
    func requireLogin() {
        let tabbar = self.navigationController?.tabBarController as! CustomTabBarController
        let loginVC = UIStoryboard(name: "HomeLogin", bundle: nil).instantiateViewController(identifier: "navHomeLogin") as! UINavigationController
        
        loginVC.tabBarItem = RAMAnimatedTabBarItem(title: "", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        (loginVC.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()
        
        if let _ = tabbar.viewControllers?.last{
            tabbar.viewControllers![3] = loginVC
            tabbar.setSelectIndex(from: 0, to: 3)
        }
    }
    
    func addIndicator() {
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        self.view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        NSLayoutConstraint.activate([
            indicator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            indicator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            indicator.topAnchor.constraint(equalTo: self.view.topAnchor),
            indicator.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        indicator.startAnimating()
    }
    
    @IBAction func orderAction(_ sender: Any) {
        addIndicator()
        let userId = FirebaseManager.shared.getUserId()
        if userId == "" || currentUser == nil{
            self.requireLogin()
            return
        }
        guard let keyAuto = FirebaseManager.shared.ref.child("OrderHistory/\(userId)").childByAutoId().key else {
            return
        }
        let dateCurrent = DateFormat.dateToString(date: Date())
        //add order detail
        let keyOrderDetail = "\(dateCurrent)-\(keyAuto)"
        var jsonCartItem: [[ String : Any ]] = []
        for cartItem in self.cartListInput {
            guard let productColorId = cartItem.productColorId else {
                print("item nil")
                return
            }
            jsonCartItem.append([
                    "shoe_id" : "\(cartItem.productId ?? "")",
                    "shoe_color_id" : "\(productColorId)",
                    "shoe_size_id" : "\(cartItem.productSizeId ?? "")",
                    "shoe_quantity" : cartItem.productQuantity,
                    "shoe_price" : cartItem.productPrice
                ])
        }
        FirebaseManager.shared.ref.child("OrderDetail/\(keyOrderDetail)").setValue(jsonCartItem)
        //add order history
        let jsonOrderHistory: [String : Any] = [
            "ship_address" : "\(self.txtAddress.text ?? "")",
            "total_price" : self.dataInput["totalPrice"] as! Int,
            "total_item" : self.dataInput["totalItem"] as! Int,
            "order_detail_id" : "\(keyOrderDetail)",
            "date_order" : "\(dateCurrent)",
            "payment_method" : "pay by cash",
            "status" : 0
        ]
        let path = "OrderHistory/\(userId)/\(keyOrderDetail)"
        FirebaseManager.shared.ref.child(path).setValue(jsonOrderHistory) { (error, ref) in
            if let error = error {
                print("Error getting data \(error)")
                FirebaseManager.shared.ref.child("OrderDetail/\(keyOrderDetail)").removeValue { error, _ in
                    print(error ?? "error nil")
                    return
                }
                return
            } else {
                self.orderSuccess()
            }
        }
    }
    
    func orderSuccess() {
        CoreDataManager.share.deleteCartAfterOrder()
        self.indicator.stopAnimating()
        self.indicator.removeFromSuperview()
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        DispatchQueue.global().async {
            MailManager.sentMailViaUserEmail(userEmail: self.currentUser!.email)
        }
        let orderSuccessPageVc = UIStoryboard(name: "OrderSuccessPage", bundle: nil).instantiateViewController(identifier: OrderSuccessViewController.identifier) as! OrderSuccessViewController
        self.navigationController?.pushViewController(orderSuccessPageVc, animated: true)
    }
    
    @IBAction func changeAddress(_ sender: Any) {
        //showAlertChangeAddress()
        let viewControllerChangeShipAddress = (storyboard?.instantiateViewController(identifier: "ChangeShipAddress"))! as ChangeShipAddressViewController
        
        viewControllerChangeShipAddress.currentUser = self.currentUser
        viewControllerChangeShipAddress.completionHandler = { [weak self] user in
            if let realUser = user {
                self?.txtAddress.text = "Phone Number: " + realUser.phoneNumber + "\n" + realUser.shipAddress
            }
        }
        
        viewControllerChangeShipAddress.modalPresentationStyle = .custom
        viewControllerChangeShipAddress.transitioningDelegate = self
        
        present(viewControllerChangeShipAddress, animated: true)
    }
    
    @IBAction func selectPayByCash(_ sender: Any) {
        // do nothing
    }
    
    
    @IBAction func selectPayByVisa(_ sender: Any) {
        
        let alert = UIAlertController(title: "Payment Method", message: "This Fuction Is Not Available Now! ", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okayAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func selectPayByPaypal(_ sender: Any) {
        
        let alert = UIAlertController(title: "Payment Method", message: "This Fuction Is Not Available Now! ", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okayAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension CheckoutViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomPresentation(presentedViewController: presented, presenting: presenting)
    }
    
}
