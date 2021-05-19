//
//  OrderHistoryTableViewCell.swift
//  shoe_shop2
//
//  Created by tientran on 09/05/2021.
//

import UIKit

class OrderHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var addressPointView: UIView!
    @IBOutlet weak var destinationPointView: UIView!
    
    @IBOutlet weak var lblDateOrder: UILabel!
    @IBOutlet weak var lblShipAddress: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addressPointView.layer.cornerRadius = addressPointView.frame.height / 2
        destinationPointView.layer.cornerRadius = addressPointView.frame.height / 2
        containerView.roundedAllSide(with: 8)
    }
    
    func configureCell(orderHistory : OrderHistory)  {
        self.lblDateOrder.text = orderHistory.dateOrder
        self.lblShipAddress.text = orderHistory.shipAddress
        self.lblTotalPrice.text = "Total: $ \(orderHistory.totalPrice)"
    }
}
