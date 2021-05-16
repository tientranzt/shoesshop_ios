import UIKit
import RAMAnimatedTabBarController

class LoginViewController: UIViewController {

    @IBOutlet weak var customTextFieldEmailAddress: CustomTextField!
    @IBOutlet weak var customTextFieldPassword: CustomTextField!
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setUpView() {

        customTextFieldEmailAddress.lblTextFieldName.text = " EMAIL ADDRESS "
        customTextFieldEmailAddress.texField.keyboardType = .emailAddress
        customTextFieldPassword.lblTextFieldName.text = " PASSWORD "
        customTextFieldPassword.isPassword = true
        btnLogin.layer.cornerRadius = 8;
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
//        let tabbar = navigationController?.tabBarController as! CustomTabBarController
//
//        let navAccountVC = UIStoryboard(name: "AccountPage", bundle: nil).instantiateViewController(identifier: "navAccountPage") as! UINavigationController
//
//        navAccountVC.tabBarItem = RAMAnimatedTabBarItem(title: "", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
//
//        (navAccountVC.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()
//
//
//        if let _ = tabbar.viewControllers?.last{
////            tabbar.viewControllers[3].
//
//            tabbar.viewControllers![3] = navAccountVC
//            tabbar.setSelectIndex(from: 0, to: 3)
//
//        }
        
        if let email = customTextFieldEmailAddress.texField.text, let password = customTextFieldPassword.texField.text {
            FirebaseManager.shared.signInWithEmail(email: email, password: password) { (result) in
                switch result {
                
                case .success(_):
                    print("dang nhap thanh cong")
                case .failure(_):
                    print("dang nhap that bai")
                }
            }
        }
     
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
