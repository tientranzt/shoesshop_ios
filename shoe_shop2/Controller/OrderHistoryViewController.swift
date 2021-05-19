//
//  OrderHistoryViewController.swift
//  shoe_shop2
//
//  Created by tientran on 09/05/2021.
//

import UIKit

class OrderHistoryViewController: UITableViewController {
    // MARK: - Properties
    private let reuseableCellIdentified = "orderHisotryCell"
    var orderHistoryList: [OrderHistory] = []
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavBackground()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        FirebaseManager.shared.fetchOrderHistory { [weak self] (snapshot) in
            if let data = snapshot.value as? [String: AnyObject] {
                data.forEach { (key : String, value: AnyObject) in
                    self?.orderHistoryList.append(FirebaseManager.shared.parseOrderHistory(object: value))
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    
    // MARK: - Helper
    
    private func configureNavBackground(){
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func configureTableView(){
        tableView.register(UINib(nibName: "OrderHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: reuseableCellIdentified)
        tableView.rowHeight = 190
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
    }
    
}


extension OrderHistoryViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderHistoryList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseableCellIdentified, for: indexPath) as! OrderHistoryTableViewCell
        cell.autoresizingMask  = [.flexibleWidth, .flexibleHeight]
        cell.backgroundColor = UIColor(named: ColorTheme.subGrayBackground)
        cell.configureCell(orderHistory: orderHistoryList[indexPath.row])
        return cell
    }
    
    
}

