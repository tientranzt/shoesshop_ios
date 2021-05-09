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
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var orderProductImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        addressPointView.layer.cornerRadius = addressPointView.frame.height / 2
        destinationPointView.layer.cornerRadius = addressPointView.frame.height / 2
        orderProductImage.layer.cornerRadius = orderProductImage.frame.height / 2
        containerView.roundedAllSide(with: 8)
    }
    
    @IBAction func orderAgainButtonTapped(_ sender: UIButton) {
        print("order button clicked")
    }
}
