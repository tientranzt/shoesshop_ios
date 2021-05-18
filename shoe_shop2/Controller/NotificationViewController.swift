import UIKit

class NotificationViewController: UITableViewController {

    var colorsName = [ColorTheme.hightlightOrangeBackground, ColorTheme.starBackground, ColorTheme.priceColor]
   
    var notificationsList :  [NotificationModel] = []

    // MARK: - Helper
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ToastMessageTableViewCell", bundle: nil), forCellReuseIdentifier: "toastMessageCell")
        fetchDataNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func fetchDataNotifications()  {
        notificationsList = []
        FirebaseManager.shared.fetchNotifications { dataSnapshot in
            if let data = dataSnapshot.value as? [String: AnyObject] {
                data.forEach { (key : String, value: AnyObject) in
                    self.notificationsList.append(FirebaseManager.shared.parseNotificationModel(key : key, object: value))
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func showAlertDeleteItem(cell: IndexPath) {
        
        let cartIndex = cell.row
        
        let alert = UIAlertController(title: "Delete item", message: "Are you sure you want to delete this item ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            
            let pathNeedDelete = self.notificationsList[cartIndex].keyPath
            FirebaseManager.shared.ref.child("Notifications/\(pathNeedDelete)").removeValue()
            self.notificationsList.remove(at: cartIndex)
            self.tableView.reloadData()
            print("Delete success")
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}


// MARK: - Extension NotificationViewController
extension NotificationViewController {

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toastMessageCell", for: indexPath) as! ToastMessageTableViewCell
        cell.configureColors(colorName: colorsName[indexPath.row])
        cell.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cell.backgroundColor = UIColor(named: ColorTheme.subGrayBackground)
        cell.initCell(notification: notificationsList[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    //MARK:- Configure + Handle swipe delete item
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            // Call edit action
            self.showAlertDeleteItem(cell: indexPath)
        })
        let iconImage = UIImage(systemName: "trash")
        deleteAction.image = iconImage!.withTintColor(UIColor(named: "deleteButtonTint")!, renderingMode: .alwaysOriginal)
        deleteAction.backgroundColor = UIColor(named: "grayMainBackground")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
