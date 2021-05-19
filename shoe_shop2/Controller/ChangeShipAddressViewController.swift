//
//  ChangeShipAddressViewController.swift
//  shoe_shop2
//
//  Created by Nhat on 5/10/21.
//

import UIKit

class ChangeShipAddressViewController: UIViewController {

    @IBOutlet weak var textViewAddress: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var textViewPhoneNumber: UITextView!
    var currentUser: User!
    
    public var completionHandler: ((User?)-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textViewAddress.layer.borderColor = UIColor(named: "middleGrayBackground")?.cgColor
        textViewAddress.layer.borderWidth = 1
        textViewAddress.layer.cornerRadius = 8
        
        textViewPhoneNumber.layer.borderColor = UIColor(named: "middleGrayBackground")?.cgColor
        textViewPhoneNumber.layer.borderWidth = 1
        textViewPhoneNumber.layer.cornerRadius = 8
        
        
        btnSave.layer.cornerRadius = 8
        textViewAddress.text = currentUser.shipAddress
        textViewPhoneNumber.text = currentUser.phoneNumber
    }
    
    @IBAction func closeScreen(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveShipAddress(_ sender: Any) {
        currentUser.shipAddress = textViewAddress.text
        currentUser.phoneNumber = textViewPhoneNumber.text
        
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(currentUser) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "user")
        }
        
        completionHandler?(currentUser)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
