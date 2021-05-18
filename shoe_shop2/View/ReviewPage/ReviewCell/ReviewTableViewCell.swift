//
//  ReviewTableViewCell.swift
//  shoe_shop2
//
//  Created by Nguyen Thanh Phuc on 5/12/21.
//

import UIKit
import FirebaseDatabase
import SDWebImage

class ReviewTableViewCell: UITableViewCell {
    var userId: String?
    
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
    override func layoutSubviews() {
        avatarUserImage.layer.cornerRadius = avatarUserImage.layer.bounds.width / 2
    }
    
    func fetchUserImage() {
        let ref = Database.database().reference()
        ref.child("UserProfile/\(userId ?? "")/imgAvatar").observe(.value) { (snapshot) in
            guard let value = snapshot.value else {
                return
            }
            guard value is String else {
                return
            }
            if let url = URL(string: value as! String){
                DispatchQueue.main.async { [self] in
                    avatarUserImage?.sd_setImage(with: url, placeholderImage: UIImage(systemName: "circles.hexagonpath"), options: .continueInBackground, completed: nil)
                }
            }else {
                let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/shoesshop-e9b03.appspot.com/o/avatar.png?alt=media&token=a653b128-9c5d-4629-8e3f-a277a527c0ae")
                DispatchQueue.main.async { [self] in
                    avatarUserImage?.sd_setImage(with: url, placeholderImage: UIImage(systemName: "circles.hexagonpath"), options: .continueInBackground, completed: nil)
                }
            }
        }
    }
    
}
