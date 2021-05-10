//
//  NotificationViewController.swift
//  shoe_shop2
//
//  Created by Nguyen Thanh Phuc on 5/7/21.
//

import UIKit

class NotificationViewController: UITableViewController {

    var colorsName = [ColorTheme.hightlightOrangeBackground, ColorTheme.starBackground, ColorTheme.priceColor]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ToastMessageTableViewCell", bundle: nil), forCellReuseIdentifier: "toastMessageCell")
        tableView.rowHeight = 90
    }
    
}


extension NotificationViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorsName.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toastMessageCell", for: indexPath) as! ToastMessageTableViewCell
        cell.configureColors(colorName: colorsName[indexPath.row])
        cell.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cell.backgroundColor = UIColor(named: ColorTheme.subGrayBackground)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
