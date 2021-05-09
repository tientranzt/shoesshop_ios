//
//  OrderHistoryViewController.swift
//  shoe_shop2
//
//  Created by tientran on 09/05/2021.
//

import UIKit

class OrderHistoryViewController: UITableViewController {
    private let reuseableCellIdentified = "orderHisotryCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "OrderHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: reuseableCellIdentified)
        tableView.rowHeight = 190
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false

    }
}


extension OrderHistoryViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseableCellIdentified, for: indexPath)
        
        return cell
    }
}

