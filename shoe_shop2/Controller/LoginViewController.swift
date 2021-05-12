import UIKit

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
        var tabbar = navigationController?.tabBarController as! RootTabbarViewController
        
        let navLoginVC = UIStoryboard(name: "AccountPage", bundle: nil).instantiateViewController(identifier: "navAccountPage") as! UINavigationController
        
        if let _ = tabbar.viewControllers?.last{
            tabbar.viewControllers![3] = navLoginVC
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
