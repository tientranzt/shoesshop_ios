//
//  UpdateUserInformationViewController.swift
//  shoe_shop2
//
//  Created by tientran on 09/05/2021.
//

import UIKit
import FirebaseStorage
class UpdateUserInformationViewController: UIViewController {
    
    @IBOutlet weak var avartarImage: UIImageView!
    @IBOutlet weak var containerStackView: UIStackView!
    private let storage = Storage.storage().reference()
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var textFieldLocation: UITextField!
    
    var saveImageDone: Bool = true;
    
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        avartarImage.layer.cornerRadius = avartarImage.frame.height / 2
        avartarImage.clipsToBounds = true
        containerStackView.roundedAllSide(with: 25)
        
        
    }
    
    @IBAction func pickImageChangeAvatar(_ sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    // fucntion update user to firebase
    @IBAction func saveUpdate(_ sender: Any) {
        
        self.view.isUserInteractionEnabled = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        if saveImageDone {
            // check text is "" if "" alert to user
            
            if textFieldLocation.text != "" && textFieldEmail.text != "" && textFieldUserName.text != "" && textFieldPhoneNumber.text != ""  {
                
                if let location = textFieldLocation.text, let email = textFieldEmail.text, let userName = textFieldUserName.text ,let phoneNumber = textFieldPhoneNumber.text {
                    if LogicLogin.shared.isValidEmail(email) && LogicLogin.shared.isValidPhoneNumber(value: phoneNumber) {
                        
                        self.user.email = email
                        self.user.phoneNumber = phoneNumber
                        self.user.userName = userName
                        self.user.shipAddress = location
                        // save to user default
                        let encoder = JSONEncoder()
                        if let encoded = try? encoder.encode(self.user) {
                            let defaults = UserDefaults.standard
                            defaults.set(encoded, forKey: "user")
                        }
                        FirebaseManager.shared.updateUser(user: self.user)
                        self.navigationController?.popViewController(animated: true)
                    }
                    else {
                        // alert wrong format emal or phonenumber
                        let alert = UIAlertController(title: "Save User Information", message: "Email Or Phone Number Not Right Format, Please Check Again!", preferredStyle: .alert)
                        let okayAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
                            self?.view.isUserInteractionEnabled = true
                            self?.navigationItem.setHidesBackButton(false, animated: true)
                        })
                        alert.addAction(okayAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                else {
                    // alert somthing wrong try it again or later
                    let alert = UIAlertController(title: "Save User Information", message: "Update Infomation Fail Please Try Again! ", preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
                        self?.view.isUserInteractionEnabled = true
                        self?.navigationItem.setHidesBackButton(false, animated: true)
                    })
                    alert.addAction(okayAction)
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
            else {
                //alert error
                let alert = UIAlertController(title: "Save User Information", message: "Some Data Is Null Please Check Again! ", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
                    self?.view.isUserInteractionEnabled = true
                    self?.navigationItem.setHidesBackButton(false, animated: true)
                })
                alert.addAction(okayAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        else {
            LogicLogin.shared.showToast(message: "waiting...", view: self.view)
        }
        
    }
    @IBAction func cancelUpdate(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let realUser = self.user else {
            return
        }
        if realUser.isNewUser == "TRUE" {
            btnCancel.isEnabled = false
        }
        
        DispatchQueue.main.async {
            self.avartarImage.sd_setImage(with: URL(string: realUser.imgAvatar), placeholderImage: UIImage(named: "avatar"), options: .continueInBackground, completed: nil)
            self.textFieldLocation.text =  realUser.shipAddress
            self.textFieldEmail.text = realUser.email
            self.textFieldUserName.text = realUser.userName
            self.textFieldPhoneNumber.text = realUser.phoneNumber
        }
        
    }
}


// MARK: - pick image

extension UpdateUserInformationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.saveImageDone = false
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage  else {
            return
        }
        
        DispatchQueue.main.async {
            self.avartarImage.image = image
        }
        
        guard let imageData = image.pngData() else {
            return
        }
        
        // upload image data
        // get download url
        // save dowload url to user defaul
        let userId = FirebaseManager.shared.getUserId()
        let uploadImageQueue = DispatchQueue(label: "upload Image")
        uploadImageQueue.async {
            self.storage.child(userId).putData( imageData, metadata: nil, completion: {[weak self] _,error in
                guard error == nil else {
                    print("upload fail")
                    return
                }
                self?.storage.child(userId).downloadURL(completion: {[weak self] (url, error) in
                    guard let url = url , error == nil else {
                        let alert = UIAlertController(title: "Save User Information", message: " Save User Information Fail! ", preferredStyle: .alert)
                        let okayAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
                            self?.view.isUserInteractionEnabled = true
                            self?.navigationItem.setHidesBackButton(false, animated: true)
                        })
                        alert.addAction(okayAction)
                        self?.present(alert, animated: true, completion: nil)
                        return
                    }
                    self?.saveImageDone = true
                    self?.user.imgAvatar = url.absoluteString
                    self?.btnSave.sendActions(for: .touchUpInside)
                })
            })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
