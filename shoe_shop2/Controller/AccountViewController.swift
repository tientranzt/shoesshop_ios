import UIKit
import SkeletonView
import RAMAnimatedTabBarController
class AccountViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var orderHistoryImage: UIImageView!
    @IBOutlet weak var updateInfoImage: UIImageView!
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var nextButton1: UIButton!
    @IBOutlet weak var nextButton2: UIButton!
    @IBOutlet weak var nextButton3: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    
    @IBOutlet weak var lblUserName: UILabel!
    
    var user: User?
    
    // MARK: -  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor(named: ColorTheme.mainBlackBackground)
    }
    
    override func viewWillLayoutSubviews() {
        borderViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchUser()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    // MARK: - Helper
    private func borderViews(){
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
        orderHistoryImage.layer.cornerRadius = orderHistoryImage.frame.height / 2
        updateInfoImage.layer.cornerRadius = orderHistoryImage.frame.height / 2
        infoImage.layer.cornerRadius = orderHistoryImage.frame.height / 2
        nextButton1.roundedAllSide(with: 8)
        nextButton2.roundedAllSide(with: 8)
        nextButton3.roundedAllSide(with: 8)
        signOutButton.roundedAllSide(with: 8)
    }
    
    // MARK: - IBAction
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            
            let orderHistoryVC = UIStoryboard(name: "AccountPage", bundle: nil).instantiateViewController(identifier: "orderHistoryVC") as! OrderHistoryViewController
            navigationController?.pushViewController(orderHistoryVC, animated: true)
            break
            
        case 1:
            
            let updateUserInfoVC = UIStoryboard(name: "AccountPage", bundle: nil).instantiateViewController(identifier: "updateUserInfo") as! UpdateUserInformationViewController
            updateUserInfoVC.user = self.user
            navigationController?.pushViewController(updateUserInfoVC, animated: true)
            
            break
            
        case 2:
            
            let infoUserInfoVC = UIStoryboard(name: "AccountPage", bundle: nil).instantiateViewController(identifier: "userInfo") as! UserInformationViewController
            infoUserInfoVC.user = self.user
            navigationController?.pushViewController(infoUserInfoVC, animated: true)
            
            break
            
        default:
            break
        }
        
    }
    // alert to user want to logout
    @IBAction func signOut(_ sender: Any) {
        let alert = UIAlertController(title: "Sign Out Message", message: "Are you sure want to Sign Out?", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default, handler: {[weak self] action in
            
            if(!FirebaseManager.shared.signOut()){
                return
            }
            DispatchQueue.main.async {
                self?.backToLogin()
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(okayAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - func firebase
    
    func fetchUser() {
        FirebaseManager.shared.fetchUser { [weak self] (dataSnapshot) in
            let data = dataSnapshot.value as AnyObject
            self?.user = FirebaseManager.shared.parseUser(object: data)
            if let realUser = self?.user {
                if realUser.isNewUser == "TRUE" {
                    DispatchQueue.main.async {
                        self?.nextButton2.sendActions(for: .touchUpInside)
                    }
                }
                DispatchQueue.main.async {
                    self?.avatarImage.sd_setImage(with: URL(string: realUser.imgAvatar), placeholderImage: UIImage(named: "avatar"), options: .continueInBackground, completed: nil)
                    self?.lblUserName.text = realUser.userName
                }
            }
        }
    }
}


extension AccountViewController {
    func backToLogin() {
        let tabbar = self.navigationController?.tabBarController as! CustomTabBarController
        let navLoginVC = UIStoryboard(name: "HomeLogin", bundle: nil).instantiateViewController(identifier: "navHomeLogin") as! UINavigationController
        navLoginVC.tabBarItem = RAMAnimatedTabBarItem(title: "", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        (navLoginVC.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()
        if let _ = tabbar.viewControllers?.last{
            tabbar.viewControllers![3] = navLoginVC
            tabbar.setSelectIndex(from: 0, to: 3)
        }
    }
}
