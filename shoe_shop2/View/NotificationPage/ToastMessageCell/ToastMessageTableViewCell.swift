//
//  ToastMessageTableViewCell.swift
//  shoe_shop2
//
//  Created by tientran on 09/05/2021.
//

import UIKit

class ToastMessageTableViewCell: UITableViewCell {
    @IBOutlet weak var seperateView: UIView!
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var bodyNotification: UILabel!
    @IBOutlet weak var removeNotificationButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureColors(colorName : String)  {
        seperateView.backgroundColor = UIColor(named: colorName)
    }
            
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        customView()
    }
    
    private func customView(){
        seperateView.roundedAllSide(with: 3)
        //containerView.roundedAllSide(with: 8)
    }
    
    func initCell(notification : NotificationModel)  {
        seperateView.backgroundColor =  UIColor(named: notification.color)
        notificationTitle.text =  notification.title
        bodyNotification.text =  notification.body

    }
    
}
