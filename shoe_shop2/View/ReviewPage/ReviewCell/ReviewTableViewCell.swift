//
//  ReviewTableViewCell.swift
//  shoe_shop2
//
//  Created by Nguyen Thanh Phuc on 5/12/21.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewContentLabel: UILabel!
    @IBOutlet weak var avatarUserImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
