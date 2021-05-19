//
//  CheckoutViewController.swift
//  shoe_shop2
//
//  Created by Nguyen Thanh Phuc on 5/7/21.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    //MARK: - Properties + Outlet
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
        setShadowForVieư(view: viewShipAddress)
        setShadowForVieư(view: viewPaymentMethod)
        btnOrder.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let saveUser = UserDefaults.standard.object(forKey: "user") as? Data {
            let decoder = JSONDecoder()
            if let loadUser = try? decoder.decode(User.self, from: saveUser) {
                txtAddress.text = "Phone Number: " + loadUser.phoneNumber + "\n" + loadUser.shipAddress
                self.currentUser = loadUser
            }
        }
    }
    
    func setData() {
        if let totalItem = dataInput["totalItem"], let totalPrice = dataInput["totalPrice"] {
            lblTotalItem.text = "\(totalItem) item"
            lblTotalPrice.text = "\(totalPrice) $"
        }
    }
    
    func setShadowForVieư(view: UIView) {
        
        view.layer.borderColor = UIColor(named: "grayMainBackground")?.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        
        view.layer.shadowColor = UIColor(red: 197/255, green: 197/255, blue: 197/255, alpha: 1).cgColor
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.2
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func orderAction(_ sender: Any) {
        
        guard let userId = dataInput["userId"] else {
            print("not found key user ID")
            return
        }
        guard let keyOrderDetail = dataInput["keyOrderDetail"] else {
            print("not found key order ID")
            return
        }
        let json: [String : Any] = [
            "ship_address" : "\(txtAddress.text ?? "")",
            "total_price" : dataInput["totalPrice"] as! Int,
            "total_item" : dataInput["totalItem"] as! Int,
            "order_detail_id" : "\(keyOrderDetail)",
            "date_order" : "\(DateFormat.dateToString(date: Date()))",
            "payment_method" : "pay by cash",
            "status" : 0
        ]
        FirebaseManager.shared.ref.child("OrderHistory/\(userId)").childByAutoId().setValue(json)
        CoreDataManager.share.deleteCartAfterOrder()
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
    
//    func showAlertChangeAddress() {
//        let alert = UIAlertController(title: "Ship address", message: "Input ship address please", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//
//        alert.addTextField(configurationHandler: { textField in
//            textField.placeholder = "input here..."
//        })
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//            guard let text = alert.textFields?.first?.text else {
//                print("input ship address nil")
//                return
//            }
//            self.txtAddress.text = text
//        }))
//        self.present(alert, animated: true)
//    }
    
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
