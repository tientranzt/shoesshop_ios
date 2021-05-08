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
    
    func setUpView() {
        // rgb(60,60,60)
        customTextFieldEmailAddress.borderView.layer.borderWidth = 1
        customTextFieldEmailAddress.borderView.layer.borderColor = UIColor.gray.cgColor
        customTextFieldEmailAddress.borderView.layer.cornerRadius = 8;
        customTextFieldEmailAddress.lblTextFieldName.text = " EMAIL ADDRESS "
        customTextFieldEmailAddress.lblTextFieldName.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        customTextFieldEmailAddress.texField.borderStyle = .none
        
        customTextFieldPassword.borderView.layer.borderWidth = 1
        customTextFieldPassword.borderView.layer.borderColor = UIColor.gray.cgColor
        customTextFieldPassword.borderView.layer.cornerRadius = 8;
        customTextFieldPassword.lblTextFieldName.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        customTextFieldPassword.lblTextFieldName.text = " PASSWORD "
        customTextFieldPassword.texField.borderStyle = .none
        
        btnLogin.layer.cornerRadius = 8;
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
