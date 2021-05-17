import UIKit

class NotificationViewController: UITableViewController {

    var colorsName = [ColorTheme.hightlightOrangeBackground, ColorTheme.starBackground, ColorTheme.priceColor]
   
    var notificationsList :  [NotificationModel] = []

    // MARK: - Helper
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ToastMessageTableViewCell", bundle: nil), forCellReuseIdentifier: "toastMessageCell")
       
        //tableView.separatorStyle = .none
        //tableView.rowHeight = 90
  
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
                    self.notificationsList.append(FirebaseManager.shared.parseNotificationModel(object: value))
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
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
}
