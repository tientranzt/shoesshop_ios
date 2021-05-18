import UIKit
import RAMAnimatedTabBarController

class LoginViewController: UIViewController {
    
    @IBOutlet weak var customTextFieldEmailAddress: CustomTextField!
    @IBOutlet weak var customTextFieldPassword: CustomTextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var switchRememberMe: CustomSwitch!
    @IBOutlet weak var labelRememberMe: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setUpView() {
        switchRememberMe.isHidden = true
        labelRememberMe.isHidden = true
        customTextFieldEmailAddress.lblTextFieldName.text = " EMAIL ADDRESS "
        customTextFieldEmailAddress.texField.keyboardType = .emailAddress
        customTextFieldPassword.lblTextFieldName.text = " PASSWORD "
        customTextFieldPassword.isPassword = true
        btnLogin.layer.cornerRadius = 8;
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        // stop user to click many times at the same time
        self.view.isUserInteractionEnabled = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        if let email = customTextFieldEmailAddress.texField.text, let password = customTextFieldPassword.texField.text{
            if email != "" && password != "" {
                if customTextFieldPassword.isRightFormat && customTextFieldEmailAddress.isRightFormat {
                    let queueLogin = DispatchQueue(label: "Queue Login")
                    queueLogin.async {
                        FirebaseManager.shared.signInWithEmail(email: email, password: password) { [weak self] (result) in
                            switch result {
                            case .success(_):
                                let tabbar = self?.navigationController?.tabBarController as! CustomTabBarController
                                let navAccountVC = UIStoryboard(name: "AccountPage", bundle: nil).instantiateViewController(identifier: "navAccountPage") as! UINavigationController
                                navAccountVC.tabBarItem = RAMAnimatedTabBarItem(title: "", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
                                (navAccountVC.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()
                                if let _ = tabbar.viewControllers?.last{
                                    tabbar.viewControllers![3] = navAccountVC
                                    tabbar.setSelectIndex(from: 0, to: 3)
                                }
                            case .failure(let error):
                                
                                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                                let okayAction = UIAlertAction(title: "OK", style: .default, handler: {[weak self] action in
                                    
                                    self?.view.isUserInteractionEnabled = true
                                    self?.navigationItem.setHidesBackButton(false, animated: true)
                                })
                                alert.addAction(okayAction)
                                self?.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                }else{
                    let alert = UIAlertController(title: "Error", message: "some data wrong format \n 1. Email need right format \n 2. Password need at least 8 characters", preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
                        self?.view.isUserInteractionEnabled = true
                        self?.navigationItem.setHidesBackButton(false, animated: true)
                    })
                    alert.addAction(okayAction)
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }else {
                let alert = UIAlertController(title: "Error", message: "Some data is null please check again!", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .default, handler: {[weak self] action in
                    self?.view.isUserInteractionEnabled = true
                    self?.navigationItem.setHidesBackButton(false, animated: true)
                })
                alert.addAction(okayAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
}
